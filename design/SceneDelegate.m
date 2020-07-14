//
//  SceneDelegate.m
//  design
//
//  Created by panwei on 7/3/20.
//

#import "SceneDelegate.h"
#import "RootTabBarContro.h"
#import "LoginTableViewController.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "MineVC.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从沙盒中获取用户信息
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
    PersonInfoModel *personInfoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (personInfoModel != nil) {
        Configure *configure = [Configure singletonInstance];
        configure.personInfoModel = personInfoModel;
        RootTabBarContro *rootTabBarContro = [mainStoryboard instantiateViewControllerWithIdentifier:@"RootTabBarContro"];
        self.window.rootViewController = rootTabBarContro;
        [self.window makeKeyAndVisible];
        rootTabBarContro.selectedIndex = 3;
        
    }else{
        LoginTableViewController *loginTableViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
        self.window.rootViewController = loginTableViewController;
        [self.window makeKeyAndVisible];
    }
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
