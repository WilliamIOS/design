//
//  ServerApi.m
//
//
//  Created by William on 15/3/23.
//
//

#import "ServerApi.h"

NSString * Base_URL_Project = @"";
NSString *Base_URL_H5 = @"";


/**登录*/
NSString *const Api_Login = @"loginAPP";
NSString *const Api_Signout = @"logoutWX";
/**我的项目*/
NSString *const Api_MyProject = @"project/projectTask/getListByTel";
/**文件列表*/
NSString *const Api_FileList = @"project/projectFiles/getFileListByProId";

@implementation ServerApi

/**设置服务器:上线IP*/
- (void)setupBaseUrl{
    Base_URL_Project = @"http://wx.banyua.com/";
    Base_URL_H5 = @"http://wx.banyua.com/";
}

@end

