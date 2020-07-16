//
//  AddressBookVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "AddressBookVC.h"
#import "Configure.h"
#import "ProjectModel.h"
#import <WebKit/WebKit.h>

@interface AddressBookVC ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *wkwebView;

@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    self.wkwebView.scrollView.bounces = NO;
    self.wkwebView.backgroundColor = [UIColor whiteColor];
    self.wkwebView.navigationDelegate = self;
    self.wkwebView.UIDelegate = self;
    
     NSString *urlStr = [NSString stringWithFormat:@"http://web.banyua.com/stuExamApp.html#/communication/1278261882460884994/12345678902?projectId=%@&username=%@&token=%@",[Configure singletonInstance].currentProjectModel.projectId,[Configure singletonInstance].personInfoModel.username,[Configure singletonInstance].personInfoModel.token];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.wkwebView loadRequest:request];
}

@end
