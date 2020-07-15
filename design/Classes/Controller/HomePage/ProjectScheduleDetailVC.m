//
//  ProjectScheduleDetailVC.m
//  design
//
//  Created by panwei on 7/15/20.
//

#import "ProjectScheduleDetailVC.h"
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

@interface ProjectScheduleDetailVC ()<MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tilteLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


@end

@implementation ProjectScheduleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = PWColor(244, 244, 244);
    self.tableView.tableFooterView = footerView;
    
    [self.contentTextView setRoundedView:self.contentTextView cornerRadius:5 borderWidth:0.5 borderColor:[UIColor lightGrayColor]];
    self.tilteLabel.text = self.scheduleListModel.workContent;
    self.timeLabel.text = [NSString stringWithFormat:@"计划周期：%@",self.scheduleListModel.planningTime];
    self.contentTextView.text = self.scheduleListModel.note;
}

@end
