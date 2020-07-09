//
//  NetworkRequest.h
//  3.0AF
//
//  Created by William on 2016/11/7.
//  Copyright © 2016年 core. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkRequest : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *manager;

#pragma mark - 网络请求成功处理的回调
typedef void(^SuccessHandle)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
#pragma mark - 网络请求失败处理的回调
typedef void(^FailHandle)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

+ (id _Nonnull)shared;

- (NSURLSessionDataTask* _Nullable)getRequest:(NSMutableDictionary * _Nullable)param serverUrl:(NSString * _Nullable)url success:(SuccessHandle _Nullable)successHandle failure:(FailHandle _Nullable)failHandle;
- (NSURLSessionDataTask* _Nullable)postRequest:(NSMutableDictionary * _Nullable)param serverUrl:(NSString * _Nullable)url success:(SuccessHandle _Nullable)successHandle failure:(FailHandle _Nullable)failHandle;
- (void)uploadPostRequest:(NSMutableDictionary * _Nullable)param serverUrl:(NSString * _Nullable)url imageDataArray:(NSMutableArray* _Nullable)imageDataArray success:(SuccessHandle _Nullable)successHandle failure:(FailHandle _Nullable)failHandle;

@end
