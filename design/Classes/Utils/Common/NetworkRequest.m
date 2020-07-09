//
//  NetworkRequest.m
//  3.0AF
//
//  Created by William on 2016/11/7.
//  Copyright © 2016年 core. All rights reserved.
//

#import "NetworkRequest.h"
#import "ServerApi.h"
#import "Configure.h"
#import "PersonInfoModel.h"
#import "UIViewController+Extension.h"
#import "ResponseObjectModel.h"
#import "MJExtension.h"
#import "MiPushSDK.h"
#import "RootTabBarContro.h"

@interface NetworkRequest()


@end

@implementation NetworkRequest

+ (id)shared{
    static NetworkRequest *networkRequest = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        networkRequest = [[self alloc] init];
    });
    return networkRequest;
}

- (NSURLSessionDataTask *)getRequest:(NSMutableDictionary *)param serverUrl:(NSString *)url success:(SuccessHandle)successHandle failure:(FailHandle)failHandle{
    if (self.manager == nil) {
        self.manager = [AFHTTPSessionManager manager];
    }

    self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    self.manager.requestSerializer.HTTPShouldHandleCookies = YES;
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 30.0f;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    if (![url isEqualToString:@"app/userLogin.do"]) {
        // 添加accessToken
        NSString *accessToken = [Configure singletonInstance].personInfoModel.accessToken;
        [param setObject:accessToken forKey:@"_accessToken_"];
    }
    
    url = [NSString stringWithFormat:@"%@%@",Base_URL_Project,url];

    NSURLSessionDataTask *datatask = [self.manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandle(task,responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failHandle(task,error);
        
        
    }];
    
    return datatask;
}

- (NSURLSessionDataTask *)postRequest:(NSMutableDictionary *)param serverUrl:(NSString *)url success:(SuccessHandle)successHandle failure:(FailHandle)failHandle{
    if (self.manager == nil) {
        self.manager = [AFHTTPSessionManager manager];
    }
    self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 60.0f;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    NSString *accessToken = [Configure singletonInstance].personInfoModel.accessToken;
    if (accessToken == nil || [accessToken isEqualToString:@""]) {
        
    }else{
        [param setObject:accessToken forKey:@"_accessToken_"];
    }
    [param setObject:@"ios" forKey:@"system"];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    [param setObject:currentVersion forKey:@"versionName"];
    
    url = [NSString stringWithFormat:@"%@%@",Base_URL_Project,url];
    
    __block NSString *logUrl = @"";
    [param enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([logUrl isEqualToString:@""] || logUrl == nil) {
            logUrl = [NSString stringWithFormat:@"%@?%@=%@",url,key,obj];
        }else{
            logUrl = [NSString stringWithFormat:@"%@&%@=%@",logUrl,key,obj];
        }
    }];
    NSLog(@"请求url连接：%@",logUrl);
    
    NSURLSessionDataTask *task = [self.manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.error isEqualToString:@"无效访问密钥"]) {
            UIViewController *topVC = [UIViewController topViewController];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失效，请重新登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 删除沙盒和内存中的用户数据
                Configure *configure = [Configure singletonInstance];
                PersonInfoModel *personInfoModel = configure.personInfoModel;
                configure.personInfoModel = nil;
                configure.personBaseInfoModel = nil;
                
                NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *accountpath = [doc stringByAppendingPathComponent:@"account.archive"];
                NSFileManager* fileManager=[NSFileManager defaultManager];
                BOOL accountpathHave=[[NSFileManager defaultManager] fileExistsAtPath:accountpath];
                if (accountpathHave) {
                    [fileManager removeItemAtPath:accountpath error:nil];
                }
                
                NSString *publishCooperationDetailModelPath = [doc stringByAppendingPathComponent:@"publishCooperationDetailModel.archive"];
                BOOL publishCooperationDetailModelHave=[[NSFileManager defaultManager] fileExistsAtPath:publishCooperationDetailModelPath];
                if (publishCooperationDetailModelHave) {
                    [fileManager removeItemAtPath:publishCooperationDetailModelPath error:nil];
                }
                
                [MiPushSDK unsetAccount:personInfoModel.userId];
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:@"" forKey:@"UMStatistics"];
                
                UIStoryboard *rootStoryboard = [UIStoryboard storyboardWithName:@"Root" bundle:nil];
                RootTabBarContro *rootTabBarContro = [rootStoryboard instantiateViewControllerWithIdentifier:@"RootTabBarContro"];
                [UIApplication sharedApplication].keyWindow.rootViewController = rootTabBarContro;
            }];
            [alertController addAction:confirmAction];
            [topVC presentViewController:alertController animated:YES completion:nil];
           
        }else{
            successHandle(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failHandle(task,error);
        
    }];
    return task;
    
}

#pragma mark - 上传图片
- (void)uploadPostRequest:(NSMutableDictionary *)param serverUrl:(NSString *)url imageDataArray:(NSMutableArray*)imageDataArray success:(SuccessHandle)successHandle failure:(FailHandle)failHandle{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg", @"image/png", nil];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    url = [NSString stringWithFormat:@"%@%@",Base_URL_Project,url];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < [imageDataArray count]; i++) {
            [formData appendPartWithFileData:imageDataArray[i] name:@"files" fileName:@"files.png" mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandle(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failHandle(task,error);
        
    }];
    
}

@end
