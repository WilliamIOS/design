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
#import "MJExtension.h"
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
    
    url = [NSString stringWithFormat:@"%@%@",Base_URL_Project,url];
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer requestWithMethod:@"GET" URLString:url parameters:param error:nil];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    self.manager.requestSerializer.timeoutInterval = 15.f;
    
    if (![url isEqualToString:@"loginAPP"]) {
        // 添加token
        NSString *token = [Configure singletonInstance].personInfoModel.token;
        [self.manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    
    __block NSString *logUrl = @"";
    [param enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([logUrl isEqualToString:@""] || logUrl == nil) {
            logUrl = [NSString stringWithFormat:@"%@?%@=%@",url,key,obj];
        }else{
            logUrl = [NSString stringWithFormat:@"%@&%@=%@",logUrl,key,obj];
        }
    }];
    NSLog(@"请求url连接：%@",logUrl);

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
    url = [NSString stringWithFormat:@"%@%@",Base_URL_Project,url];
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:param error:nil];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    self.manager.requestSerializer.timeoutInterval = 15.f;
    if (![url isEqualToString:@"loginAPP"]) {
        // 添加token
        NSString *token = [Configure singletonInstance].personInfoModel.token;
        [self.manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    
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
        successHandle(task,responseObject);
        
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
