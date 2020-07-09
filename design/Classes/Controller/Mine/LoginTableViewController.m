//
//  LoginTableViewController.m
//  design
//
//  Created by panwei on 2020/7/7.
//

#import "LoginTableViewController.h"

@interface LoginTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor= [UIColor whiteColor];
    UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_background"]];
    self.tableView.backgroundView = imageView;
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)loginBtnClick:(id)sender{
    
}

@end
