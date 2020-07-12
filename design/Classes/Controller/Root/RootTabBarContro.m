//
//  RootTabBarContro.m
//  YData
//
//  Created by panwei on 2017/10/12.
//  Copyright © 2017年 huifangkeji. All rights reserved.
//

#import "RootTabBarContro.h"
#import "Macro.h"
#import "ServerApi.h"
//#import "UITabBar+Badge.h"
//#import <MNFloatBtn/MNFloatBtn.h>
//#import "ServerApi.h"
//#import "DebugToolsHomePageNavigationContro.h"
//#import "UIViewController+Extension.h"
//#import "PersonInfoModel.h"
//#import "Configure.h"
//#import "MiPushSDK.h"

@interface RootTabBarContro ()<UITabBarControllerDelegate,UITabBarDelegate>


@end

@implementation RootTabBarContro

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有的子控制器
    [self addAllChildVCs];
    // 设置UITabBarControllerDelegate代理委托
    self.delegate = self;
    // 设置UINavigationBar背景颜色
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    // UINavigationBar标题
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    // UINavigationBar的UIBarButtonItem的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    // UITabBarItem默认/选中标题的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:PWColor(235, 141, 26)} forState:UIControlStateSelected];
    [[UINavigationBar appearance] setTranslucent:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.selectedViewController viewWillAppear:animated];
    
    ServerApi *serverApi = [[ServerApi alloc] init];
    [serverApi setupBaseUrl];
}

/**
 添加所有子控制器
 */
-(void)addAllChildVCs{
    UINavigationController *homePageListNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageListNavigationController"];
    [self addOneChlildVc:homePageListNavigationController tabBarItemTitle:@"项目资料" imageName:@"xiangmu" selectedImageName:@"xiangmuCheck"];
    
    UINavigationController *scheduleNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleNavigationController"];
    [self addOneChlildVc:scheduleNavigationController tabBarItemTitle:@"变更日程" imageName:@"richeng" selectedImageName:@"richengCheck"];
    
    UINavigationController *addressBookNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressBookNavigationController"];
    [self addOneChlildVc:addressBookNavigationController tabBarItemTitle:@"项目通讯录" imageName:@"tongxun" selectedImageName:@"tongxunCheck"];
    
    UINavigationController *mineNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"MineNavigationController"];
    [self addOneChlildVc:mineNavigationController tabBarItemTitle:@"我的项目" imageName:@"liebiao" selectedImageName:@"liebiao"];
}

/**
 添加一个子控制器
 */
- (void)addOneChlildVc:(UINavigationController *)childNavCon tabBarItemTitle:(NSString *)tabBarItemTitle imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    childNavCon.tabBarItem.title = tabBarItemTitle;// tabbar标签上
    
    // 设置图标
    childNavCon.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childNavCon.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 添加为tabbar控制器的子控制器
    [self addChildViewController:childNavCon];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIViewController *currentViewController = tabBarController.selectedViewController;
    if (currentViewController == viewController) {
        // 重复点击了当前controller
    }
    return YES;
}

@end

