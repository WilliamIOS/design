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
#import "ProjectModel.h"
#import "NetworkRequest.h"
#import "MJRefresh.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *projectListTV;
@property (nonatomic,strong) NSMutableArray *prjectDataListTotalMutableArray;
@property (nonatomic,strong) NSMutableArray *prjectDataListMutableArray;

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

    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.prjectDataListMutableArray = [self.prjectDataListTotalMutableArray mutableCopy];
        [self.projectListTV.mj_footer setState:(MJRefreshStateNoMoreData)];
        [self.projectListTV reloadData];
    }];
    self.projectListTV.mj_footer = footer;
    [footer setTitle:@"暂无更多项目" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"更多" forState:MJRefreshStateIdle];
    [self.projectListTV.mj_footer setState:(MJRefreshStateIdle)];
}

- (NSMutableArray*)prjectDataListMutableArray{
    if (!_prjectDataListMutableArray) {
        self.prjectDataListMutableArray = [NSMutableArray array];
    }
    return _prjectDataListMutableArray;
}

- (NSMutableArray*)prjectDataListTotalMutableArray{
    if (!_prjectDataListTotalMutableArray) {
        self.prjectDataListTotalMutableArray = [NSMutableArray array];
    }
    return _prjectDataListTotalMutableArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.prjectDataListMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineProjectTVC *mineProjectTVC = [MineProjectTVC cellWithTableView:tableView cellidentifier:@"MineProjectTVC"];
    mineProjectTVC.projectModel = self.prjectDataListMutableArray[indexPath.row];
    return mineProjectTVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectModel *selectedProjectModel = self.prjectDataListMutableArray[indexPath.row];
    [Configure singletonInstance].currentProjectModel = selectedProjectModel;
    RootTabBarContro *rootTabBarContro = [self.storyboard instantiateViewControllerWithIdentifier:@"RootTabBarContro"];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootTabBarContro;
}

- (void)myProjectInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[Configure singletonInstance].personInfoModel.username forKey:@"username"];
    
    [[NetworkRequest shared] getRequest:dic serverUrl:Api_MyProject success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            self.prjectDataListTotalMutableArray = [ProjectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if ([self.prjectDataListTotalMutableArray count] > 3) {
                [self.prjectDataListMutableArray addObject:self.prjectDataListTotalMutableArray[0]];
                [self.prjectDataListMutableArray addObject:self.prjectDataListTotalMutableArray[1]];
                [self.prjectDataListMutableArray addObject:self.prjectDataListTotalMutableArray[2]];
                [self.projectListTV.mj_footer setState:(MJRefreshStateIdle)];
            }else{
                self.prjectDataListMutableArray = [self.prjectDataListTotalMutableArray mutableCopy];
                [self.projectListTV.mj_footer setState:(MJRefreshStateNoMoreData)];
            }
            
        }else{
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
        [self.projectListTV reloadData];
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
