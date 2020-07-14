//
//  ConceptSchemeListVC.m
//  design
//
//  Created by panwei on 7/9/20.
//

#import "ConceptSchemeListVC.h"
#import "LoadingFileTVC.h"
#import "UIView+Extension.h"
#import "Macro.h"
#import "ConceptSchemeHistoryListVC.h"
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

@interface ConceptSchemeListVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fileListTV;
@property (weak, nonatomic) IBOutlet UIView *loadingFileView;
@property (weak, nonatomic) IBOutlet UIView *checkHistoryFileView;
@property (nonatomic,strong) NSMutableArray *loadingFileModelMutableArray;
@property (nonatomic,strong) NSMutableArray *pdfMutableArray;
@property (nonatomic,strong) NSMutableArray *dwgMutableArray;
@property (nonatomic,strong) NSMutableArray *rarMutableArray;
@property (nonatomic,strong) NSMutableArray *otherMutableArray;

@end

@implementation ConceptSchemeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self conceptSchemeInterface];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的项目";
    self.fileListTV.delegate = self;
    self.fileListTV.dataSource = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.fileListTV.mj_footer = footer;
    [footer setTitle:@"暂无更多概念方案文件" forState:MJRefreshStateNoMoreData];
    [self.loadingFileView setRoundedView:self.loadingFileView cornerRadius:10 borderWidth:4 borderColor:PWColor(33, 136, 184)];
    [self.checkHistoryFileView setRoundedView:self.checkHistoryFileView cornerRadius:10 borderWidth:4 borderColor:PWColor(33, 136, 184)];
    UITapGestureRecognizer *loadingFileViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadingFileViewGesture:)];
    [self.loadingFileView addGestureRecognizer:loadingFileViewTap];
    UITapGestureRecognizer *checkHistoryFileViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkHistoryFileViewGesture:)];
    [self.checkHistoryFileView addGestureRecognizer:checkHistoryFileViewTap];
    [self.fileListTV.mj_footer setState:(MJRefreshStateNoMoreData)];
    
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
    LoadingFileTVC *loadingFileTVC = [LoadingFileTVC cellWithTableView:tableView cellidentifier:@"LoadingFileTVCWithConceptScheme"];
    loadingFileTVC.loadingFileModel = self.loadingFileModelMutableArray[indexPath.row];
    return loadingFileTVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingFileModel *loadingFileModel = self.loadingFileModelMutableArray[indexPath.row];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
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
                NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
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
    return [self.loadingFileModelMutableArray count];
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    LoadingFileModel *loadingFileModel = self.loadingFileModelMutableArray[index];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
    return [NSURL fileURLWithPath:path];;
}

- (void)loadingFileViewGesture:(UITapGestureRecognizer*)recognizer {
    
}

- (void)checkHistoryFileViewGesture:(UITapGestureRecognizer*)recognizer {
    ConceptSchemeHistoryListVC *conceptSchemeHistoryListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConceptSchemeHistoryListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:conceptSchemeHistoryListVC animated:true];
}


- (void)conceptSchemeInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    [dic setObject:@"41" forKey:@"documentSort"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_FileList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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



#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud{
    self.view.userInteractionEnabled = YES;
    NSString *msg = hud.detailsLabel.text;
    if ([msg isEqualToString:@""]) {
        
    }else{
        
    }
}

@end
