//
//  LoadingFileModel.m
//  design
//
//  Created by panwei on 7/13/20.
//

#import "LoadingFileModel.h"
#import "AFNetworking.h"

@implementation LoadingFileModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"fileId":@"id"};
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
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:weakSelf.documentName];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        fileLoadingSuccessHandle(response, filePath, error);

    }];
    // 4. 开启下载任务
    [downloadTask resume];
}

@end
