//
//  ScheduleNavigationController.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "ScheduleNavigationController.h"

@interface ScheduleNavigationController ()

@end

@implementation ScheduleNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *scheduleListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleListVC"];
    self.viewControllers = @[scheduleListVC];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}



@end
