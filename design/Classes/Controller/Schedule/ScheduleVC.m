//
//  ScheduleVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "ScheduleVC.h"
#import "Configure.h"
#import "ProjectModel.h"

@interface ScheduleVC ()

@end

@implementation ScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
}


@end
