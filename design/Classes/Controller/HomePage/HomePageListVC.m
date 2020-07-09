//
//  HomePageListVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "HomePageListVC.h"
#import "HomePageBtnsTVC.h"
#import "ProjectScheduleTVC.h"
#import "ConceptSchemeListVC.h"

@interface HomePageListVC ()<UITableViewDelegate,UITableViewDataSource,HomePageBtnsTVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homePageTV;

@end

@implementation HomePageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的项目";
    self.homePageTV.dataSource = self;
    self.homePageTV.delegate = self;
    self.homePageTV.estimatedRowHeight = 300.0f;//估算高度
    self.homePageTV.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
       HomePageBtnsTVC *homePageBtnsTVC = [HomePageBtnsTVC cellWithTableView:tableView cellidentifier:@"HomePageBtnsTVC"];
        homePageBtnsTVC.delegate = self;
        cell = homePageBtnsTVC;

    }else if (indexPath.section == 1){
        ProjectScheduleTVC *projectScheduleTVC = [ProjectScheduleTVC cellWithTableView:tableView cellidentifier:@"ProjectScheduleTVC"];
        cell = projectScheduleTVC;
    }else{

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat h = 0.0001;
    if (section == 0 ) {
        h = 10.0f;
    }
    return h;
}

#pragma mark - HomePageBtnsTVCDelegate
- (void)didConceptSchemeBtn{
    ConceptSchemeListVC *conceptSchemeListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConceptSchemeListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:conceptSchemeListVC animated:true];
}
@end
