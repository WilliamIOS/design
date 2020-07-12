//
//  ServerApi.h
//
//
//  Created by William on 15/3/23.
//
//

#import <Foundation/Foundation.h>

extern NSString *Base_URL_Project;
extern NSString *Base_URL_H5;

/**登录*/
extern NSString *const Api_Login;
/**我的项目*/
extern NSString *const Api_MyProject;

@interface ServerApi : NSObject

/**设置服务器环境*/
- (void)setupBaseUrl;

@end

