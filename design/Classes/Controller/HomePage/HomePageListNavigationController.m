//
//  HomePageListNavigationController.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "HomePageListNavigationController.h"

@interface HomePageListNavigationController ()

@end

@implementation HomePageListNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *homePageListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageListVC"];
    self.viewControllers = @[homePageListVC];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}


@end
