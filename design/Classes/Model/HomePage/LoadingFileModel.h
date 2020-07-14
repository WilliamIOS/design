//
//  LoadingFileModel.h
//  design
//
//  Created by panwei on 7/13/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingFileModel : NSObject

#pragma mark - 网络请求成功处理的回调
typedef void(^FileLoadingSuccessHandle)(NSURLResponse *response, NSURL *filePath, NSError *error);

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *delFlag;
@property (nonatomic,strong) NSString *deleteDate;
@property (nonatomic,strong) NSString *deleter;
@property (nonatomic,strong) NSString *documentName;
@property (nonatomic,strong) NSString *documentSort;
@property (nonatomic,strong) NSString *documentUrl;
@property (nonatomic,strong) NSString *fileId;
@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) NSString *tenantCode;
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updater;
// 文件名后缀
@property (nonatomic,strong) NSString *fileSuffixStr;
// 是否选中
@property (nonatomic,assign) BOOL isChecked;

// 文件下载
- (void)fileLoading:(FileLoadingSuccessHandle)fileLoadingSuccessHandle;

@end

NS_ASSUME_NONNULL_END
