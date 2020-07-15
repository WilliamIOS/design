//
//  Macro.h
//
//
//  Created by William on 16/10/8.
//  Copyright © 2016年 William. All rights reserved.
//

#define currentScreenH   ([UIScreen mainScreen].bounds.size.height)
#define currentScreenW   ([UIScreen mainScreen].bounds.size.width)

/**导航栏+状态栏的高度*/
//#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

/**颜色*/
#define PWColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

/**当前手机屏幕1个像素的宽度*/
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

/** 当前手机屏幕1个像素的偏移量（疑问：偏移了后，位置不就不准确了？*/
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

/**快速取出NSUserDefaults里面key的对应数值*/
#define NSUserDefaults(param)    [[NSUserDefaults standardUserDefaults] objectForKey:(param)]

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif


typedef NS_ENUM(NSInteger, ViewControllerType) {
    ViewControllerTypeWithConceptScheme,
    ViewControllerTypeWithPlaneFigure,
    ViewControllerTypeWithDesignSketch,
    ViewControllerTypeWithConstructionPlans,
    ViewControllerTypeWithSoftLoading,
    ViewControllerTypeWithOtherFile
};



