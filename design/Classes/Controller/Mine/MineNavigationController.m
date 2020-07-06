//
//  MineNavigationController.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "MineNavigationController.h"

@interface MineNavigationController ()

@end

@implementation MineNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *mineVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MineVC"];
    self.viewControllers = @[mineVC];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}



@end
