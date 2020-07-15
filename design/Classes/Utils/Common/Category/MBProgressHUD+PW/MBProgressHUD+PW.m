//
//  MBProgressHUD+PW.m
//  HudDemo
//
//  Created by William on 2016/12/2.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import "MBProgressHUD+PW.h"

@implementation MBProgressHUD (PW)

/**
 菊花转

 @param targetView 添加的目标view
 */
+ (void)showChrysanthemumWithView:(UIView*)targetView delegateTarget:(id)delegate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    targetView.userInteractionEnabled = NO;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor darkGrayColor];
    hud.detailsLabel.text = @"请稍等...";
//    hud.detailsLabel.textColor = [UIColor whiteColor];
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:18]];
    

    hud.delegate = delegate;
}
/**
 只有菊花转
 
 @param targetView 添加的目标view
 */
+ (void)showOnlyChrysanthemumWithView:(UIView*)targetView delegateTarget:(id)delegate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];  
    targetView.userInteractionEnabled = NO;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor darkGrayColor];
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:18]];
    hud.delegate = delegate;
}

/**
 只有菊花转
 整个背景是白色的
 
 @param targetView 添加的目标view
 */
+ (void)showOnlyChrysanthemumWithWhiteBackgroundView:(UIView*)targetView delegateTarget:(id)delegate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    targetView.userInteractionEnabled = NO;
    hud.backgroundColor = [UIColor whiteColor];
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor lightGrayColor];
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:18]];
    hud.delegate = delegate;
}

/**
 菊花转，可以自定义提示语
 
 @param targetView 添加的目标view
 */
+ (MBProgressHUD *)showChrysanthemumWithView:(UIView *)targetView hintMsg:(NSString *)msg delegateTarget:(id)delegate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    targetView.userInteractionEnabled = NO;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor darkGrayColor];
//    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.text = msg;
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:18]];
    hud.delegate = delegate;
    return hud;
}

/**
 普通显示
 
 @param msg 提示语
 @param targetView 添加的目标view
 */
+ (void)showMessage:(NSString *)msg targetView:(UIView *)targetView delegateTarget:(id)delegate{
    [self show:msg imageName:nil targetView:targetView delegateTarget:delegate];
    
}

/**
 普通显示
 
 @param msg 提示语
 @param targetView 添加的目标view
 @param delay 停留时间
 */
+ (void)showMessage:(NSString *)msg targetView:(UIView *)targetView delegateTarget:(id)delegate delay:(NSTimeInterval)delay{
    [self show:msg imageName:nil targetView:targetView delegateTarget:delegate delay:delay];
    
}

/**
 操作成功

 @param success 成功提示语
 @param targetView 添加的目标view
 */
+ (void)showSuccess:(NSString *)success targetView:(UIView *)targetView delegateTarget:(id)delegate{
    [self show:success imageName:@"Checkmark" targetView:targetView delegateTarget:delegate];
}

/**
 屏幕下方提示
 
 @param msg 提示语言
 */
+ (void)showBottomMessage:(NSString *)msg targetView:(UIView *)targetView delegateTarget:(id)delegate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:18]];
    hud.delegate = delegate;
    hud.offset = CGPointMake(0.f, 150.0f);
//    hud.detailsLabel.textColor = [UIColor whiteColor];
//    hud.bezelView.backgroundColor = [UIColor darkGrayColor];
    [hud hideAnimated:YES afterDelay:1.5f];
}

/**
 取消目标view上的MBProgressHUD
 
 @param targetView 添加的目标view
 */
+ (void)hideHUDForView:(UIView *)targetView{
    [self hideHUDForView:targetView animated:YES];

}

+ (void)show:(NSString *)text imageName:(NSString*)imageNameStr targetView:(UIView *)targetView delegateTarget:(id)delegate{
    if (targetView == nil) targetView = [[UIApplication sharedApplication].windows lastObject];    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    targetView.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.delegate = delegate;
    UIImage *image = [[UIImage imageNamed:imageNameStr] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.detailsLabel.text = text;
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:18]];
//    hud.detailsLabel.textColor = [UIColor whiteColor];
//    hud.bezelView.backgroundColor = [UIColor darkGrayColor];
    
    if (imageNameStr == nil || [imageNameStr isEqualToString:@""]) {
        hud.offset = CGPointMake(0.f, 150.0f);
    }
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0f];
}

+ (void)show:(NSString *)text imageName:(NSString*)imageNameStr targetView:(UIView *)targetView delegateTarget:(id)delegate delay:(NSTimeInterval)delay{
    if (targetView == nil) targetView = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    targetView.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.delegate = delegate;
    UIImage *image = [[UIImage imageNamed:imageNameStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.detailsLabel.text = text;
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:18]];
//    hud.detailsLabel.textColor = [UIColor whiteColor];
//    hud.bezelView.backgroundColor = [UIColor darkGrayColor];
    hud.offset = CGPointMake(0.f, 150.0f);
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

@end
