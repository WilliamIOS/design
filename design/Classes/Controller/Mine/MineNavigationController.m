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
    UIViewController *personalCentreVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalCentreVC"];
    self.viewControllers = @[personalCentreVC];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}



@end
