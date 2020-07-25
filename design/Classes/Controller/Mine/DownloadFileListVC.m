//
//  DownloadFileListVC.m
//  design
//
//  Created by panwei on 7/23/20.
//

#import "DownloadFileListVC.h"
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
#import "LocalFileInfoModel.h"

@interface DownloadFileListVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fileListTV;
@property (nonatomic,strong) NSMutableArray *loadingFileModelMutableArray;
@property (nonatomic,strong) LoadingFileModel *willPreviewLoadingFileModel;
@property (nonatomic,strong) LocalFileInfoModel *localFileInfoModel;

@end

@implementation DownloadFileListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. LoadingFileTVCWithDownloadFile
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.fileListTV.delegate = self;
    self.fileListTV.dataSource = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.fileListTV.mj_footer = footer;
    [footer setTitle:@"暂无更多已下载文件" forState:MJRefreshStateNoMoreData];
    [self.fileListTV.mj_footer setState:(MJRefreshStateNoMoreData)];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = PWColor(244, 244, 244);
    self.fileListTV.tableFooterView = footerView;
    
    // 取出本地文件
    NSMutableArray *resMutableArray = [self localFileCollection];
    self.loadingFileModelMutableArray = [resMutableArray mutableCopy];
    // 取出本地文件的相关信息
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fileDirectoryName = [NSString stringWithFormat:@"%@_%@",[Configure singletonInstance].currentProjectModel.projectId,[Configure singletonInstance].personInfoModel.username];
//    NSString *fileDirectoryPath = [documentPath stringByAppendingPathComponent:fileDirectoryName];
//    NSString *localFileInfoModelPath = [fileDirectoryPath stringByAppendingPathComponent:@"fileInfo.archive"];
//    self.localFileInfoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:localFileInfoModelPath];
    
    [self.fileListTV reloadData];
    
}

- (NSMutableArray*)loadingFileModelMutableArray{
    if (!_loadingFileModelMutableArray) {
        self.loadingFileModelMutableArray = [NSMutableArray array];
    }
    return _loadingFileModelMutableArray;
}

- (NSMutableArray*)localFileCollection{
    NSMutableArray *resMutableArray = [NSMutableArray array];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDirectoryName = [NSString stringWithFormat:@"%@_%@",[Configure singletonInstance].currentProjectModel.projectId,[Configure singletonInstance].personInfoModel.username];
    NSString *fileDirectoryPath = [documentPath stringByAppendingPathComponent:fileDirectoryName];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *DirectoryArray = [fileManager contentsOfDirectoryAtPath:fileDirectoryPath error:nil];
    for (int a = 0; a<[DirectoryArray count]; a++) {
        NSString *fileName = DirectoryArray[a];
        LoadingFileModel *loadingFileModel = [[LoadingFileModel alloc] init];
        loadingFileModel.documentName = fileName;
        [resMutableArray addObject:loadingFileModel];
    }
    return resMutableArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.loadingFileModelMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingFileTVC *loadingFileTVC = [LoadingFileTVC cellWithTableView:tableView cellidentifier:@"LoadingFileTVCWithDownloadFile"];
    loadingFileTVC.currentIndexPath = indexPath;
    loadingFileTVC.loadingFileModel = self.loadingFileModelMutableArray[indexPath.row];
    return loadingFileTVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingFileModel *loadingFileModel = self.loadingFileModelMutableArray[indexPath.row];
    self.willPreviewLoadingFileModel = loadingFileModel;
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
    FileManager *fileManager = [[FileManager alloc] init];
    NSString *path = [fileManager jointFilePath:self.willPreviewLoadingFileModel.documentName];
    return [NSURL fileURLWithPath:path];;
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
