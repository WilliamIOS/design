//
//  ProjectScheduleVC.m
//  design
//
//  Created by panwei on 7/10/20.
//

#import "ProjectScheduleVC.h"
#import "FSCalendar.h"
#import "PlanListTVC.h"

@interface ProjectScheduleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UITableView *planListTV;

@end

@implementation ProjectScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的项目";
    self.planListTV.dataSource = self;
    self.planListTV.delegate = self;
    self.planListTV.estimatedRowHeight = 100.0f;//估算高度
    self.planListTV.rowHeight = UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlanListTVC *planListTVC = [PlanListTVC cellWithTableView:tableView cellidentifier:@"PlanListTVC"];
    return planListTVC;
}
@end
