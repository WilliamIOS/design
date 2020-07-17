//
//  ScheduleVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "ScheduleVC.h"
#import "Configure.h"
#import "ProjectModel.h"
#import <WebKit/WebKit.h>
#import "LoadingFileModel.h"
#import "NetworkRequest.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "ResponseObjectModel.h"
#import "UITabBar+Badge.h"

@interface ScheduleVC ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>

@property (weak, nonatomic) IBOutlet WKWebView *wkwebView;

@end

@implementation ScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [self remindStatusHandle];
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
    
    NSString *urlStr = [NSString stringWithFormat:@"http://web.banyua.com/stuExamApp.html#/changeDateDay/1278261882460884994/12345678902?projectId=%@&username=%@&token=%@",[Configure singletonInstance].currentProjectModel.projectId,[Configure singletonInstance].personInfoModel.username,[Configure singletonInstance].personInfoModel.token];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.wkwebView loadRequest:request];
}

- (void)remindStatusHandle{
    NSMutableArray *remindDataMutableArray = [Configure singletonInstance].remindDataMutableArray;
    for (int i = 0; i < [remindDataMutableArray count]; i++) {
        LoadingFileModel *loadingFileModel = remindDataMutableArray[i];
        if ([loadingFileModel.updateName isEqualToString:@"变更日程"]) {
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                [self updateRemindStatusInterface:loadingFileModel];
            }
            break;
        }else{
        }
    }
}

#pragma mark - 提醒状态变更
- (void)updateRemindStatusInterface:(LoadingFileModel*)loadingFileModel{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    [dic setObject:loadingFileModel.fileId forKey:@"updateId"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_UpdateRemindStatus success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            loadingFileModel.status = @"0";
            [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}


@end
