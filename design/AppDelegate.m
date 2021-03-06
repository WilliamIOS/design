//
//  AppDelegate.m
//  design
//
//  Created by panwei on 7/3/20.
//

#import "AppDelegate.h"
#import "RootTabBarContro.h"
#import "LoginTableViewController.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "MineVC.h"
#import "ServerApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从沙盒中获取用户信息
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
    PersonInfoModel *personInfoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    ServerApi *serverApi = [[ServerApi alloc] init];
    [serverApi setupBaseUrl];
    
    if (personInfoModel != nil) {
        Configure *configure = [Configure singletonInstance];
        configure.personInfoModel = personInfoModel;
//        RootTabBarContro *rootTabBarContro = [mainStoryboard instantiateViewControllerWithIdentifier:@"RootTabBarContro"];
        
        MineVC *mineVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MineVC"];
        UINavigationController *avi = [[UINavigationController alloc] initWithRootViewController:mineVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = avi;
        
        self.window.rootViewController = avi;
        [self.window makeKeyAndVisible];
        
    }else{
        LoginTableViewController *loginTableViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
        self.window.rootViewController = loginTableViewController;
        [self.window makeKeyAndVisible];
    }

    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
