//
//  PanoramicNavigationController.m
//  design
//
//  Created by panwei on 7/17/20.
//

#import "PanoramicNavigationController.h"

@interface PanoramicNavigationController ()

@end

@implementation PanoramicNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *panoramicVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PanoramicVC"];
    self.viewControllers = @[panoramicVC];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
