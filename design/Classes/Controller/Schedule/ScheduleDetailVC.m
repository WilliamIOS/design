//
//  ScheduleDetailVC.m
//  design
//
//  Created by panwei on 7/21/20.
//

#import "ScheduleDetailVC.h"
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
#import "ScheduleDetailHeaderTVC.h"
#import "ScheduleDetailSeparateTVC.h"
#import "UITabBar+Badge.h"

@interface ScheduleDetailVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *scheduleDetailTV;
@property (weak, nonatomic) IBOutlet UIView *loadingFileView;
@property (nonatomic,strong) NSMutableArray *loadingFileModelMutableArray;
@property (nonatomic,strong) NSMutableArray *pdfMutableArray;
@property (nonatomic,strong) NSMutableArray *dwgMutableArray;
@property (nonatomic,strong) NSMutableArray *rarMutableArray;
@property (nonatomic,strong) NSMutableArray *otherMutableArray;
@property (nonatomic,strong) LoadingFileModel *willPreviewLoadingFileModel;

@end

@implementation ScheduleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self changeScheduleFileListInterface];
    [self updateRemindStatusInterface];
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

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.scheduleDetailTV.delegate = self;
    self.scheduleDetailTV.dataSource = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

    }];
    self.scheduleDetailTV.mj_footer = footer;
    [footer setTitle:@"暂无更多日程文件" forState:MJRefreshStateNoMoreData];
    [self.scheduleDetailTV.mj_footer setState:(MJRefreshStateNoMoreData)];
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = PWColor(244, 244, 244);
    self.scheduleDetailTV.tableFooterView = footerView;
    
    [self.loadingFileView setRoundedView:self.loadingFileView cornerRadius:10 borderWidth:4 borderColor:PWColor(30, 133, 95)];
    UITapGestureRecognizer *loadingFileViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadingFileViewGesture:)];
    [self.loadingFileView addGestureRecognizer:loadingFileViewTap];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
    if (section == 0) {
        num = 1;
        
    }else{
        num = [self.loadingFileModelMutableArray count] + 1;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        ScheduleDetailHeaderTVC *scheduleDetailHeaderTVC = [ScheduleDetailHeaderTVC cellWithTableView:tableView cellidentifier:@"ScheduleDetailHeaderTVC"];
        scheduleDetailHeaderTVC.changeScheduleListModel = self.changeScheduleListModel;
        cell = scheduleDetailHeaderTVC;
        
    }else{
        if (indexPath.row == 0) {
            ScheduleDetailSeparateTVC *scheduleDetailSeparateTVC = [ScheduleDetailSeparateTVC cellWithTableView:tableView cellidentifier:@"ScheduleDetailSeparateTVC"];
            cell = scheduleDetailSeparateTVC;
            
        }else{
            LoadingFileTVC *loadingFileTVC = [LoadingFileTVC cellWithTableView:tableView cellidentifier:@"LoadingFileTVCWithScheduleDetail"];
            loadingFileTVC.currentIndexPath = indexPath;
            loadingFileTVC.loadingFileModel = self.loadingFileModelMutableArray[indexPath.row - 1];
            return loadingFileTVC;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat h = 0.00001f;
    if (section != 0) {
        h = 10.0f;
    }
    return h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row != 0) {
        LoadingFileModel *loadingFileModel = self.loadingFileModelMutableArray[indexPath.row - 1];
        self.willPreviewLoadingFileModel = loadingFileModel;
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
                    [self.scheduleDetailTV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
}

#pragma mark - QLPreviewControllerDataSource
-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachesPath stringByAppendingPathComponent:self.willPreviewLoadingFileModel.documentName];
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

#pragma mark - 变更日程文件
- (void)changeScheduleFileListInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.changeScheduleListModel.scheduleId forKey:@"changeId"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_ChangeScheduleFileList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        [self.scheduleDetailTV reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:@"网络延迟请稍后再试" targetView:self.view delegateTarget:self];
    }];
}

#pragma mark - 批量下载
- (void)batchFileLoadingInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    
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

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_FileBatchLoading success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documentPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        
    }];
    // 4. 开启下载任务
    [downloadTask resume];
}

- (void)remindStatusListInterface{
    
}

#pragma mark - 提醒状态变更
- (void)updateRemindStatusInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    [dic setObject:@"7" forKey:@"updateId"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_UpdateRemindStatus success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            NSMutableArray *remindDataMutableArray = [Configure singletonInstance].remindDataMutableArray;
            for (int a = 0; a < [remindDataMutableArray count]; a++) {
                LoadingFileModel *loadingFileModel = remindDataMutableArray[a];
                if ([loadingFileModel.updateName isEqualToString:@"变更日程"]) {
                    loadingFileModel.status = @"0";
                }
            }
            [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
            
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

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
