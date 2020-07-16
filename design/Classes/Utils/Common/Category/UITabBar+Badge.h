//
//  UITabBar+Badge.h
//  hydrive
//
//  Created by William on 16/10/10.
//  Copyright © 2016年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

 /**显示小红点*/
- (void)showBadgeOnItemIndex:(int)index;
/**隐藏小红点*/
- (void)hideBadgeOnItemIndex:(int)index;

@end
