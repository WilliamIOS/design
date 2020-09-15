//
//  ConceptSchemeHistoryListVC.m
//  design
//
//  Created by panwei on 2020/7/9.
//

#import "ConceptSchemeHistoryListVC.h"
#import "LoadingFileTVC.h"
#import "UIView+Extension.h"
#import "Macro.h"
#import "MJRefresh.h"
#import "MBProgressHUD+PW.h"
#import "NetworkRequest.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "ResponseObjectModel.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "LoadingFileModel.h"
#import <QuickLook/QuickLook.h>
#import "FileManager.h"

@interface ConceptSchemeHistoryListVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fileListTV;
@property (weak, nonatomic) IBOutlet UIView *loadingFileView;
@property (nonatomic,strong) NSMutableArray *loadingFileModelMutableArray;
@property (nonatomic,strong) NSMutableArray *pdfMutableArray;
@property (nonatomic,strong) NSMutableArray *dwgMutableArray;
@property (nonatomic,strong) NSMutableArray *rarMutableArray;
@property (nonatomic,strong) NSMutableArray *otherMutableArray;
@property (nonatomic,strong) LoadingFileModel *willPreviewLoadingFileModel;

@end

@implementation ConceptSchemeHistoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self conceptSchemeHistoryInterface];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.fileListTV.delegate = self;
    self.fileListTV.dataSource = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.fileListTV.mj_footer = footer;
    [footer setTitle:@"暂无更多历史文件" forState:MJRefreshStateNoMoreData];
    [self.fileListTV.mj_footer setState:(MJRefreshStateNoMoreData)];
    
    [self.loadingFileView setRoundedView:self.loadingFileView cornerRadius:10 borderWidth:4 borderColor:[UIColor lightGrayColor]];
    UITapGestureRecognizer *loadingFileViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadingFileViewGesture:)];
    [self.loadingFileView addGestureRecognizer:loadingFileViewTap];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = PWColor(244, 244, 244);
    self.fileListTV.tableFooterView = footerView;
}

- (NSMutableArray*)loadingFileModelMutableArray{
    if (!_loadingFileModelMutableArray) {
        self.loadingFileModelMutableArray = [NSMutableArray array];
    }
    return _loadingFileModelMutableArray;
}

- (NSMutableArray*)pdfMutableArray{
    if (!_pdfMutableArray) {
        self.pdfMutableArray = [NSMutableArray array];
    }
    return _pdfMutableArray;
}

- (NSMutableArray*)dwgMutableArray{
    if (!_dwgMutableArray) {
        self.dwgMutableArray = [NSMutableArray array];
    }
    return _dwgMutableArray;
}

- (NSMutableArray*)rarMutableArray{
    if (!_rarMutableArray) {
        self.rarMutableArray = [NSMutableArray array];
    }
    return _rarMutableArray;
}

- (NSMutableArray*)otherMutableArray{
    if (!_otherMutableArray) {
        self.otherMutableArray = [NSMutableArray array];
    }
    return _otherMutableArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.loadingFileModelMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingFileTVC *loadingFileTVC = [LoadingFileTVC cellWithTableView:tableView cellidentifier:@"LoadingFileTVCWithConceptSchemeHistory"];
    loadingFileTVC.currentIndexPath = indexPath;
    loadingFileTVC.loadingFileModel = self.loadingFileModelMutableArray[indexPath.row];
    return loadingFileTVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingFileModel *loadingFileModel = self.loadingFileModelMutableArray[indexPath.row];
    self.willPreviewLoadingFileModel = loadingFileModel;
//    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
    FileManager *fileManager = [[FileManager alloc] init];
    NSString *path = [fileManager jointFilePath:loadingFileModel.documentName];
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL pathHave = [manager fileExistsAtPath:path];
    
    if (pathHave) {
        if ([QLPreviewController canPreviewItem:(id<QLPreviewItem>)[NSURL fileURLWithPath:path]]) {
            QLPreviewController *previewController = [[QLPreviewController alloc] init];
            previewController.delegate = self;
            previewController.dataSource = self;
            [self presentViewController:previewController animated:YES completion:nil];
            
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"文件无法预览" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }else{
        [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
        __weak typeof(self) weakSelf = self;
        [loadingFileModel fileLoading:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:weakSelf.view];
            if (error == nil) {
                [self.fileListTV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//                NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
                FileManager *fileManager = [[FileManager alloc] init];
                NSString *path = [fileManager jointFilePath:loadingFileModel.documentName];
                
                if ([QLPreviewController canPreviewItem:(id<QLPreviewItem>)[NSURL fileURLWithPath:path]]) {
                    QLPreviewController *previewController = [[QLPreviewController alloc] init];
                    previewController.delegate = self;
                    previewController.dataSource = self;
                    [self presentViewController:previewController animated:YES completion:nil];
                    
                }else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"文件无法预览" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertController addAction:confirmAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"文件加载出现意外" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertController addAction:confirmAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

#pragma mark - QLPreviewControllerDataSource
-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
//    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [cachesPath stringByAppendingPathComponent:self.willPreviewLoadingFileModel.documentName];
    FileManager *fileManager = [[FileManager alloc] init];
    NSString *path = [fileManager jointFilePath:self.willPreviewLoadingFileModel.documentName];
    return [NSURL fileURLWithPath:path];;
}

- (void)loadingFileViewGesture:(UITapGestureRecognizer*)recognizer {
    __block BOOL haveChecked = false;
    [self.loadingFileModelMutableArray enumerateObjectsUsingBlock:^(LoadingFileModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isChecked) {
            haveChecked = true;
            *stop = true;
        }
    }];
    
    if (haveChecked) {
        [MBProgressHUD showChrysanthemumWithView:self.view hintMsg:@"批量下载中" delegateTarget:self];
        [self batchFileLoadingInterface];
    }else{
        [MBProgressHUD showMessage:@"请至少选择一个文件下载" targetView:self.view delegateTarget:self];
    }
}

#pragma mark - 文件列表
- (void)conceptSchemeHistoryInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    if (self.viewControllerType == ViewControllerTypeWithConceptScheme) {
        [dic setObject:@"41" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithPlaneFigure){
        [dic setObject:@"42" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithDesignSketch){
        [dic setObject:@"43" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithConstructionPlans){
        [dic setObject:@"44" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithSoftLoading){
        [dic setObject:@"45" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithOtherFile){
        [dic setObject:@"46" forKey:@"documentSort"];
    }
    

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_FileHistoryList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            NSMutableArray *dataMutableArray = [LoadingFileModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.pdfMutableArray = [dataMutableArray[0] mutableCopy];
            self.dwgMutableArray = [dataMutableArray[1] mutableCopy];
            self.rarMutableArray = [dataMutableArray[2] mutableCopy];
            self.otherMutableArray = [dataMutableArray[3] mutableCopy];
            // 合并
            [self.loadingFileModelMutableArray addObjectsFromArray:[self.pdfMutableArray copy]];
            [self.loadingFileModelMutableArray addObjectsFromArray:[self.dwgMutableArray copy]];
            [self.loadingFileModelMutableArray addObjectsFromArray:[self.rarMutableArray copy]];
            [self.loadingFileModelMutableArray addObjectsFromArray:[self.otherMutableArray copy]];
            
        }else{
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
        [self.fileListTV reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:@"网络延迟请稍后再试" targetView:self.view delegateTarget:self];
    }];
}

#pragma mark - 批量下载
- (void)batchFileLoadingInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    if (self.viewControllerType == ViewControllerTypeWithConceptScheme) {
        [dic setObject:@"41" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithPlaneFigure){
        [dic setObject:@"42" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithDesignSketch){
        [dic setObject:@"43" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithConstructionPlans){
        [dic setObject:@"44" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithSoftLoading){
        [dic setObject:@"45" forKey:@"documentSort"];
    }else if (self.viewControllerType == ViewControllerTypeWithOtherFile){
        [dic setObject:@"46" forKey:@"documentSort"];
    }
    
    __block NSString *files = @"";
    [self.loadingFileModelMutableArray enumerateObjectsUsingBlock:^(LoadingFileModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isChecked) {
            if ([files isEqualToString:@""]) {
                files = obj.documentUrl;
            }else{
                files = [NSString stringWithFormat:@"%@,%@",files,obj.documentUrl];
            }
        }
    }];
    [dic setObject:files forKey:@"files"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_FileHistoryBatchLoading success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            NSString *urlStr = responseObject[@"data"];
            [self fileLoading:urlStr];
            
        }else{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:@"网络延迟请稍后再试" targetView:self.view delegateTarget:self];
    }];
}

- (void)fileLoading:(NSString *)url{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString * urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [documentPath stringByAppendingPathComponent:response.suggestedFilename];
        
        FileManager *fileManager = [[FileManager alloc] init];
        NSString *path = [fileManager jointFilePath:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        [MBProgressHUD showMessage:@"下载完成，文件保存在“我的->已下载文件”" targetView:weakSelf.view delegateTarget:self];
        
    }];
    // 4. 开启下载任务
    [downloadTask resume];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud{
    self.view.userInteractionEnabled = YES;
    NSString *msg = hud.detailsLabel.text;
    if ([msg isEqualToString:@""]) {
        
    }else{
        
    }
}

@end
