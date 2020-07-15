//
//  ProjectScheduleVC.m
//  design
//
//  Created by panwei on 7/10/20.
//

#import "ProjectScheduleVC.h"
#import "FSCalendar.h"
#import "PlanListTVC.h"
#import "UIView+Extension.h"
#import "Macro.h"
#import "MJRefresh.h"
#import "MBProgressHUD+PW.h"
#import "NetworkRequest.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "ResponseObjectModel.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "ScheduleListModel.h"
#import "ProjectScheduleDetailVC.h"

@interface ProjectScheduleVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UITableView *planListTV;
@property (nonatomic,strong) NSMutableArray *scheduleListModelMutableArray;

@end

@implementation ProjectScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self scheduleListInterface];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.planListTV.dataSource = self;
    self.planListTV.delegate = self;
    self.planListTV.estimatedRowHeight = 100.0f;//估算高度
    self.planListTV.rowHeight = UITableViewAutomaticDimension;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.planListTV.mj_footer = footer;
    [footer setTitle:@"暂无更多进度日程" forState:MJRefreshStateNoMoreData];
    [self.planListTV.mj_footer setState:(MJRefreshStateNoMoreData)];
    
    UIView *footerView = [[UIView alloc] init];
    self.planListTV.tableFooterView = footerView;
}

- (NSMutableArray*)scheduleListModelMutableArray{
    if (!_scheduleListModelMutableArray) {
        self.scheduleListModelMutableArray = [NSMutableArray array];
    }
    return _scheduleListModelMutableArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.scheduleListModelMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlanListTVC *planListTVC = [PlanListTVC cellWithTableView:tableView cellidentifier:@"PlanListTVC"];
    planListTVC.scheduleListModel = self.scheduleListModelMutableArray[indexPath.row];
    return planListTVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectScheduleDetailVC *projectScheduleDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectScheduleDetailVC"];
    projectScheduleDetailVC.scheduleListModel = self.scheduleListModelMutableArray[indexPath.row];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:projectScheduleDetailVC animated:true];
}

#pragma mark - 进度日历列表
- (void)scheduleListInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_ScheduleList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            self.scheduleListModelMutableArray =  [ScheduleListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
        }else{
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
        [self.planListTV reloadData];
        
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
