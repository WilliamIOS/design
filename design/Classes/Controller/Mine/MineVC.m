//
//  MineVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "MineVC.h"
#import "MineProjectTVC.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *projectListTV;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的项目";
    self.projectListTV.dataSource = self;
    self.projectListTV.delegate = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineProjectTVC *mineProjectTVC = [MineProjectTVC cellWithTableView:tableView cellidentifier:@"MineProjectTVC"];
    return mineProjectTVC;
}

@end
