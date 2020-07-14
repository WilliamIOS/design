//
//  UIViewController+Extension.h
//  ddd
//
//  Created by William on 2017/2/10.
//  Copyright © 2017年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

+ (UIViewController *)topViewController;
/**获取父ViewController*/
+ (UIViewController *)supviewController:(id)child;


@end
