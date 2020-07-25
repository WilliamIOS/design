//
//  ScheduleListVC.m
//  design
//
//  Created by panwei on 7/21/20.
//

#import "ScheduleListVC.h"
#import "Configure.h"
#import "NetworkRequest.h"
#import "MBProgressHUD+PW.h"
#import "ResponseObjectModel.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "PersonInfoModel.h"
#import "LoadingFileModel.h"
#import "ScheduleListTVC.h"
#import "MJRefresh.h"
#import "ScheduleDetailVC.h"
#import "ChangeScheduleListModel.h"
#import "Macro.h"
#import "UITabBar+Badge.h"
#import "ScheduleInsertVC.h"

@interface ScheduleListVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *scheduleListTV;
@property (weak, nonatomic) IBOutlet UIButton *insertBtn;
@property (nonatomic,strong) NSMutableArray *changeScheduleListModelMutableArray;

@end

@implementation ScheduleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self changeScheduleListInterface];
}

- (NSMutableArray*)changeScheduleListModelMutableArray{
    if (!_changeScheduleListModelMutableArray) {
        self.changeScheduleListModelMutableArray = [NSMutableArray array];
    }
    return _changeScheduleListModelMutableArray;
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.scheduleListTV.dataSource = self;
    self.scheduleListTV.delegate = self;
    self.scheduleListTV.estimatedRowHeight = 70.0f;//估算高度
    self.scheduleListTV.rowHeight = UITableViewAutomaticDimension;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.scheduleListTV.mj_footer = footer;
    [footer setTitle:@"暂无更多日程" forState:MJRefreshStateNoMoreData];
    [self.scheduleListTV.mj_footer setState:(MJRefreshStateNoMoreData)];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = PWColor(244, 244, 244);
    self.scheduleListTV.tableFooterView = footerView;
    
    [self.insertBtn addTarget:self action:@selector(insertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.changeScheduleListModelMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleListTVC *scheduleListTVC = [ScheduleListTVC cellWithTableView:tableView cellidentifier:@"ScheduleListTVC"];
    scheduleListTVC.changeScheduleListModel = self.changeScheduleListModelMutableArray[indexPath.row];
    return scheduleListTVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleDetailVC *scheduleDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleDetailVC"];
    scheduleDetailVC.changeScheduleListModel = self.changeScheduleListModelMutableArray[indexPath.row];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:scheduleDetailVC animated:true];
}

- (void)insertBtnClick:(id)sender{
    ScheduleInsertVC *scheduleInsertVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleInsertVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:scheduleInsertVC  animated:true];}

#pragma mark - 变更日程列表
- (void)changeScheduleListInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    
    [[NetworkRequest shared] getRequest:dic serverUrl:Api_ChangeScheduleList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            self.changeScheduleListModelMutableArray = [ChangeScheduleListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
        }else{
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
        [self.scheduleListTV reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:@"网络延迟请稍后再试" targetView:self.view delegateTarget:self];
    }];
}

- (void)remindStatusListInterface{
    NSMutableArray *remindDataMutableArray = [Configure singletonInstance].remindDataMutableArray;
    for (int a = 0; a < [remindDataMutableArray count]; a++) {
        LoadingFileModel *loadingFileModel = remindDataMutableArray[a];
        if ([loadingFileModel.updateName isEqualToString:@"变更日程"]) {
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                [self.tabBarController.tabBar showBadgeOnItemIndex:2];
            }else{
                [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
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
