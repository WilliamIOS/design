//
//  HomePageListVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "HomePageListVC.h"
#import "HomePageBtnsTVC.h"

@interface HomePageListVC ()<UITableViewDelegate,UITableViewDataSource>

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageBtnsTVC *homePageBtnsTVC = [HomePageBtnsTVC cellWithTableView:tableView cellidentifier:@"HomePageBtnsTVC"];
    return homePageBtnsTVC;
}


@end
