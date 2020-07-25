//
//  LoadingFileModel.m
//  design
//
//  Created by panwei on 7/13/20.
//

#import "LoadingFileModel.h"
#import "AFNetworking.h"
#import "FileManager.h"
#import <objc/runtime.h>

@implementation LoadingFileModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"fileId":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        id value = [self valueForKey:name];
        //归档到文件中
        [aCoder encodeObject:value forKey:name];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count =0;
        //1.取出所有的属性
        objc_property_t *propertes = class_copyPropertyList([self class], &count);
        //2.遍历所有的属性
        for (int i = 0; i < count; i++) {
            //获取当前遍历到的属性名称
            const char *propertyName = property_getName(propertes[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            //解归档前遍历得到的属性的值
            id value = [aDecoder decodeObjectForKey:name];
            //             self.className = [decoder decodeObjectForKey:@"className"];
            [self setValue:value forKey:name];
        }
    }
    return self;
}

#pragma mark - 文件下载
- (void)fileLoading:(FileLoadingSuccessHandle)fileLoadingSuccessHandle{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString * urlStr = [self.documentUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [cachesPath stringByAppendingPathComponent:weakSelf.documentName];
        
        FileManager *fileManager = [[FileManager alloc] init];
        NSString *path = [fileManager jointFilePath:weakSelf.documentName];
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        FileManager *fileManager = [[FileManager alloc] init];
//        [fileManager writeDataInfoInLocalFileInfoModel:self];
        fileLoadingSuccessHandle(response, filePath, error);

    }];
    // 4. 开启下载任务
    [downloadTask resume];
}

@end
