//
//  AddressBookVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "AddressBookVC.h"
#import "Configure.h"
#import "ProjectModel.h"

@interface AddressBookVC ()

@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
}

@end
