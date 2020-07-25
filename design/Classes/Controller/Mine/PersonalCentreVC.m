//
//  PersonalCentreVC.m
//  design
//
//  Created by panwei on 7/21/20.
//

#import "PersonalCentreVC.h"
#import "MineVC.h"
#import "MineProjectTVC.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "Macro.h"
#import "ResponseObjectModel.h"
#import "RootTabBarContro.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "AFNetworking.h"
#import "MBProgressHUD+PW.h"
#import "LoginTableViewController.h"
#import "ProjectModel.h"
#import "NetworkRequest.h"
#import "MJRefresh.h"
#import "DownloadFileListVC.h"

@interface PersonalCentreVC ()<MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *projectListBtn;
@property (weak, nonatomic) IBOutlet UIButton *allDownloadFileBtn;
@property (weak, nonatomic) IBOutlet UIButton *signoutBtn;


@end

@implementation PersonalCentreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的";
    [self.projectListBtn addTarget:self action:@selector(projectListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.allDownloadFileBtn addTarget:self action:@selector(allDownloadFileBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.signoutBtn addTarget:self action:@selector(signoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.userNameLabel.text = [Configure singletonInstance].personInfoModel.username;
}

- (void)projectListBtnClick:(id)sender{
    MineVC *mineVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MineVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:mineVC animated:true];
}

- (void)allDownloadFileBtnClick:(id)sender{
    DownloadFileListVC *downloadFileListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DownloadFileListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:downloadFileListVC animated:true];
}

- (void)signoutBtnClick:(id)sender{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
        [self signoutInterface];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)signoutInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [[NetworkRequest shared] postRequest:dic serverUrl:Api_Signout success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            // 删除沙盒和内存中的用户数据
            Configure *configure = [Configure singletonInstance];
            configure.personInfoModel = nil;
            
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

            NSFileManager* fileManager=[NSFileManager defaultManager];
            NSArray *DirectoryArray = [fileManager contentsOfDirectoryAtPath:doc error:nil];
            for (int a = 0; a<[DirectoryArray count]; a++) {
                NSString *fileName = DirectoryArray[a];
                NSString *fullPath = [doc stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:fullPath error:nil];
            }

            LoginTableViewController *loginTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
            [UIApplication sharedApplication].keyWindow.rootViewController = loginTableViewController;
            
        }else{
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
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
