//
//  AddressBookNavigationController.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "AddressBookNavigationController.h"

@interface AddressBookNavigationController ()

@end

@implementation AddressBookNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *addressBookListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressBookListVC"];
    self.viewControllers = @[addressBookListVC];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}



@end
