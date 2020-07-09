//
//  MBProgressHUD+PW.h
//  HudDemo
//
//  Created by William on 2016/12/2.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (PW)


/**
 菊花转
 
 @param targetView 添加的目标view
 */
+ (void)showChrysanthemumWithView:(UIView *)targetView delegateTarget:(id)delegate;

/**
 菊花转，可以自定义提示语
 
 @param targetView 添加的目标view
 */
+ (MBProgressHUD *)showChrysanthemumWithView:(UIView *)targetView hintMsg:(NSString *)msg delegateTarget:(id)delegate;

/**
 只有菊花转
 
 @param targetView 添加的目标view
 */
+ (void)showOnlyChrysanthemumWithView:(UIView*)targetView delegateTarget:(id)delegate;

+ (void)showOnlyChrysanthemumWithWhiteBackgroundView:(UIView*)targetView delegateTarget:(id)delegate;

/**
 普通显示
 
 @param msg 提示语
 @param targetView 添加的目标view
 */
+ (void)showMessage:(NSString *)msg targetView:(UIView *)targetView delegateTarget:(id)delegate;


/**
 普通显示
 
 @param msg 提示语
 @param targetView 添加的目标view
 @param delay 界面停留时间
 */
+ (void)showMessage:(NSString *)msg targetView:(UIView *)targetView delegateTarget:(id)delegate delay:(NSTimeInterval)delay;

/**
 操作成功
 @param success 成功提示语
 @param targetView 添加的目标view
 */
+ (void)showSuccess:(NSString *)success targetView:(UIView *)targetView delegateTarget:(id)delegate;


/**
 屏幕下方展现提示语

 @param msg 提示语言
 */
+ (void)showBottomMessage:(NSString *)msg targetView:(UIView *)targetView delegateTarget:(id)delegate;

/**
 取消目标view上的MBProgressHUD
 
 @param targetView 添加的目标view
 */
+ (void)hideHUDForView:(UIView *)targetView;




@end
