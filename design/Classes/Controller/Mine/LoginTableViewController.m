//
//  LoginTableViewController.m
//  design
//
//  Created by panwei on 2020/7/7.
//

#import "LoginTableViewController.h"
#import "MBProgressHUD+PW.h"
#import "NetworkRequest.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "Macro.h"
#import "AFNetworking.h"
#import "ResponseObjectModel.h"
#import "RootTabBarContro.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "MineVC.h"

@interface LoginTableViewController ()<MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *loginBtnCoverView;
@property (weak, nonatomic) IBOutlet UITextField *accountNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSettings];

}

- (void)setupSettings{
    self.tableView.backgroundColor= [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_background_transparent"]];
    self.tableView.backgroundView = imageView;

    
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.accountNameTextField addTarget:self action:@selector(accountNameTextFieldValueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldValueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    self.loginBtnCoverView.hidden = false;
    
}

- (void)accountNameTextFieldValueChanged:(id)sender{
    if (![self.accountNameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
        self.loginBtnCoverView.hidden = true;
    }else{
        self.loginBtnCoverView.hidden = false;
    }
}

- (void)passwordTextFieldValueChanged:(id)sender{
    if (![self.accountNameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
        self.loginBtnCoverView.hidden = true;
        
    }else{
        self.loginBtnCoverView.hidden = false;
    }
}

- (void)loginBtnClick:(id)sender{
    [self.accountNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self loginInterface];
}

- (void)loginInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.accountNameTextField.text forKey:@"username"];
    [dic setObject:self.passwordTextField.text forKey:@"password"];
    [dic setObject:@"wx" forKey:@"userType"];

    [[NetworkRequest shared] postRequest:dic serverUrl:Api_Login success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            PersonInfoModel *personInfoModel = [PersonInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            Configure *configure = [Configure singletonInstance];
            configure.personInfoModel = personInfoModel;
            // 写入沙盒
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
            [NSKeyedArchiver archiveRootObject:personInfoModel toFile:path];
            
//            RootTabBarContro *rootTabBarContro = [self.storyboard instantiateViewControllerWithIdentifier:@"RootTabBarContro"];
//            [UIApplication sharedApplication].keyWindow.rootViewController = rootTabBarContro;
//            rootTabBarContro.selectedIndex = 4;
            
            MineVC *mineVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MineVC"];
            UINavigationController *avi = [[UINavigationController alloc] initWithRootViewController:mineVC];
            [UIApplication sharedApplication].keyWindow.rootViewController = avi;
            
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
