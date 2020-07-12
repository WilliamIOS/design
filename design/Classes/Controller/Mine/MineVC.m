//
//  MineVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

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

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *projectListTV;
@property (weak, nonatomic) IBOutlet UIButton *signoutBtn;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self myProjectInterface];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的项目";
    self.projectListTV.dataSource = self;
    self.projectListTV.delegate = self;
    self.projectListTV.estimatedRowHeight = 100.0f;//估算高度
    self.projectListTV.rowHeight = UITableViewAutomaticDimension;
    [self.signoutBtn addTarget:self action:@selector(signoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)signoutBtnClick:(id)sender{
    // 退出登录
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 删除沙盒和内存中的用户数据
        Configure *configure = [Configure singletonInstance];
        configure.personInfoModel = nil;
        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *accountpath = [doc stringByAppendingPathComponent:@"account.archive"];
        NSFileManager* fileManager=[NSFileManager defaultManager];
        BOOL accountpathHave=[[NSFileManager defaultManager] fileExistsAtPath:accountpath];
        if (accountpathHave) {
            [fileManager removeItemAtPath:accountpath error:nil];
        }
        LoginTableViewController *loginTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
        [UIApplication sharedApplication].keyWindow.rootViewController = loginTableViewController;
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineProjectTVC *mineProjectTVC = [MineProjectTVC cellWithTableView:tableView cellidentifier:@"MineProjectTVC"];
    return mineProjectTVC;
}

- (void)myProjectInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].personInfoModel.username forKey:@"username"];
//    [dic setObject:[Configure singletonInstance].personInfoModel.token forKey:@"token"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Base_URL_Project,Api_MyProject];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:dic error:nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer setValue:[Configure singletonInstance].personInfoModel.token forHTTPHeaderField:@"token"];
    [manager POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
           
            
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
