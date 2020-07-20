//
//  PanoramicVC.m
//  design
//
//  Created by panwei on 7/17/20.
//

#import "PanoramicVC.h"
#import "Configure.h"
#import "ProjectModel.h"
#import <WebKit/WebKit.h>
#import "LoadingFileModel.h"
#import "NetworkRequest.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "ResponseObjectModel.h"
#import "UITabBar+Badge.h"
#import "MBProgressHUD+PW.h"

@interface PanoramicVC ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet WKWebView *wkwebView;

@end

@implementation PanoramicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:true];
    [self.wkwebView removeObserver:self forKeyPath:@"estimatedProgress"];
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
    
     self.wkwebView.navigationDelegate = self;
     self.wkwebView.UIDelegate = self;
    
    [self.wkwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
     
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[Configure singletonInstance].currentProjectModel.panoramicUrl]];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self.wkwebView loadRequest:request];
}

#pragma mark - 监听加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object ==self.wkwebView) {
            if(self.wkwebView.estimatedProgress >=1.0f) {
                [MBProgressHUD hideHUDForView:self.view];
                
            }
        }
    }
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
