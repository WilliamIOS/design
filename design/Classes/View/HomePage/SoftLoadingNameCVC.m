//
//  SoftLoadingNameCVC.m
//  design
//
//  Created by panwei on 7/10/20.
//

#import "SoftLoadingNameCVC.h"
#import "Macro.h"
#import "AFNetworking.h"
#import "LoadingFileModel.h"
#import "UIViewController+Extension.h"
#import "MBProgressHUD+PW.h"
#import <QuickLook/QuickLook.h>
#import "Configure.h"
#import "LoadingFileModel.h"
#import "NetworkRequest.h"
#import "ResponseObjectModel.h"
#import "ServerApi.h"
#import "MJExtension.h"
#import "FileManager.h"

@interface SoftLoadingNameCVC()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSMutableArray *currentDataMutableArray;
@property (nonatomic,strong) LoadingFileModel *willPreviewLoadingFileModel;

@property (weak, nonatomic) IBOutlet UIView *remindStatusView;


@end

@implementation SoftLoadingNameCVC

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (NSMutableArray*)currentDataMutableArray{
    if (!_currentDataMutableArray) {
        self.currentDataMutableArray = [NSMutableArray array];
    }
    return _currentDataMutableArray;
}

- (void)setBtnNameStr:(NSString *)btnNameStr{
    _btnNameStr = btnNameStr;
    self.titleLabel.text = btnNameStr;
    if (self.currentIndexPath.item == 0) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.currentDataMutableArray = self.dataMutableArray[0];
        
    }else if (self.currentIndexPath.item == 1){
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        self.currentDataMutableArray = self.dataMutableArray[1];
        
    }else if (self.currentIndexPath.item == 2){
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        self.currentDataMutableArray = self.dataMutableArray[2];
        
    }else if (self.currentIndexPath.item == 3){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.currentDataMutableArray = self.dataMutableArray[3];
        
    }else if (self.currentIndexPath.item == 4){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.currentDataMutableArray = self.dataMutableArray[4];
        
    }else if (self.currentIndexPath.item == 5){
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        self.currentDataMutableArray = self.dataMutableArray[5];
        
    }else if (self.currentIndexPath.item == 6){
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        self.currentDataMutableArray = self.dataMutableArray[6];
        
    }else if (self.currentIndexPath.item == 7){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.currentDataMutableArray = self.dataMutableArray[7];
        
    }else if (self.currentIndexPath.item == 8){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.currentDataMutableArray = self.dataMutableArray[8];
        
    }else if (self.currentIndexPath.item == 9){//
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        [self.currentDataMutableArray removeAllObjects];
        
    }else if (self.currentIndexPath.item == 10){
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        self.currentDataMutableArray = self.dataMutableArray[9];
        
    }else if (self.currentIndexPath.item == 11){//
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.currentDataMutableArray removeAllObjects];
        
    }else if (self.currentIndexPath.item == 12){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.currentDataMutableArray = self.dataMutableArray[10];
        
    }else if (self.currentIndexPath.item == 13){//
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        [self.currentDataMutableArray removeAllObjects];
        
    }else if (self.currentIndexPath.item == 14){
        self.contentView.backgroundColor = PWColor(255, 243, 253);
        self.currentDataMutableArray = self.dataMutableArray[11];
        
    }else if (self.currentIndexPath.item == 15){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.currentDataMutableArray = self.dataMutableArray[12];
        
    }else{
        
    }
    
    if ([self.currentDataMutableArray count] > 0) {
        [self.titleLabel setTextColor:[UIColor blackColor]];
        self.titleLabel.userInteractionEnabled = true;
    }else{
        [self.titleLabel setTextColor:[UIColor lightGrayColor]];
        self.titleLabel.userInteractionEnabled = false;
    }
    UITapGestureRecognizer *titleLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelGesture:)];
    [self.titleLabel addGestureRecognizer:titleLabelTap];
    
    self.remindStatusView.hidden = true;
    NSMutableArray *remindDataMutableArray = [Configure singletonInstance].remindDataMutableArray;
    for (int i = 0; i < [remindDataMutableArray count]; i++) {
        LoadingFileModel *loadingFileModel = remindDataMutableArray[i];
        if ([loadingFileModel.updateName isEqualToString:@"家具清单"]) {
            if ([btnNameStr isEqualToString:@"家具清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"装饰灯具清单"]){
            if ([btnNameStr isEqualToString:@"装饰灯具清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"工程灯具清单"]){
            if ([btnNameStr isEqualToString:@"工程灯具清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"软装清单"]){
            if ([btnNameStr isEqualToString:@"软装清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"窗帘清单"]){
            if ([btnNameStr isEqualToString:@"软装清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"五金清单"]){
            if ([btnNameStr isEqualToString:@"五金清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"洁具清单"]){
            if ([btnNameStr isEqualToString:@"具清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"主材清单"]){
            if ([btnNameStr isEqualToString:@"主材清单"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"材料样板"]){
            if ([btnNameStr isEqualToString:@"材料样板"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"定制家具CAD图纸"]){
            if ([btnNameStr isEqualToString:@"定制家具CAD图纸"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"花灯深化CAD图纸"]){
            if ([btnNameStr isEqualToString:@"花灯深化CAD图纸"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"工程灯具点位CAD图纸"]){
            if ([btnNameStr isEqualToString:@"工程灯具点位CAD图纸"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"定制艺术品图纸"]){
            if ([btnNameStr isEqualToString:@"定制艺术品图纸"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }else if([loadingFileModel.updateName isEqualToString:@"图纸变更"]){
            if ([btnNameStr isEqualToString:@"图纸变更"] && [loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStatusView.hidden = false;
                break;
            }
        }
    }
}

- (void)titleLabelGesture:(UITapGestureRecognizer*)recognizer {
    NSMutableArray *remindDataMutableArray = [Configure singletonInstance].remindDataMutableArray;
    for (int i = 0; i < [remindDataMutableArray count]; i++) {
        LoadingFileModel *loadingFileModel = remindDataMutableArray[i];
        if ([loadingFileModel.updateName isEqualToString:self.btnNameStr]) {
            [self updateRemindStatusInterface:loadingFileModel targetView:self.remindStatusView];
            break;
        }
    }
    
    UIViewController *topViewController = [UIViewController topViewController];
    [MBProgressHUD showOnlyChrysanthemumWithView:topViewController.view delegateTarget:topViewController];
    LoadingFileModel *loadingFileModel = self.currentDataMutableArray[0];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString * urlStr = [loadingFileModel.documentUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
        
        FileManager *fileManager = [[FileManager alloc] init];
        NSString *path = [fileManager jointFilePath:loadingFileModel.documentName];
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [MBProgressHUD hideHUDForView:topViewController.view];
        if (error == nil) {
            [self preview:loadingFileModel];
        }else{
            [MBProgressHUD showBottomMessage:@"文件预览失败" targetView:topViewController.view delegateTarget:topViewController];
        }

    }];
    // 4. 开启下载任务
    [downloadTask resume];
}

- (void)preview:(LoadingFileModel*)loadingFileModel{
    self.willPreviewLoadingFileModel = loadingFileModel;
    UIViewController *topViewController = [UIViewController topViewController];
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
            [topViewController presentViewController:previewController animated:YES completion:nil];
            
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"文件无法预览" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:confirmAction];
            [topViewController presentViewController:alertController animated:YES completion:nil];
        }
        
    }else{
        [MBProgressHUD showOnlyChrysanthemumWithView:topViewController.view delegateTarget:topViewController];
//        __weak typeof(self) weakSelf = self;
        [loadingFileModel fileLoading:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:topViewController.view];
            if (error == nil) {
//                NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//                NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
                
                FileManager *fileManager = [[FileManager alloc] init];
                NSString *path = [fileManager jointFilePath:loadingFileModel.documentName];
                if ([QLPreviewController canPreviewItem:(id<QLPreviewItem>)[NSURL fileURLWithPath:path]]) {
                    QLPreviewController *previewController = [[QLPreviewController alloc] init];
                    previewController.delegate = self;
                    previewController.dataSource = self;
                    [topViewController presentViewController:previewController animated:YES completion:nil];
                    
                }else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"文件无法预览" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertController addAction:confirmAction];
                    [topViewController presentViewController:alertController animated:YES completion:nil];
                }
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"文件加载出现意外" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertController addAction:confirmAction];
                [topViewController presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

#pragma mark - 提醒状态变更
- (void)updateRemindStatusInterface:(LoadingFileModel*)loadingFileModel targetView:(UIView*)redDoteView{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    [dic setObject:loadingFileModel.fileId forKey:@"updateId"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_UpdateRemindStatus success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            loadingFileModel.status = @"0";
            redDoteView.hidden = true;
            
        }else{
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
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

@end
