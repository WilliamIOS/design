//
//  FileManager.m
//  design
//
//  Created by panwei on 7/23/20.
//

#import "FileManager.h"
#import "Configure.h"
#import "LocalFileInfoModel.h"

@implementation FileManager

#pragma mark - 创建文件夹
- (BOOL)creatDir:(NSString *)path{
    if (path.length==0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isSuccess = YES;
    BOOL isExist = [fileManager fileExistsAtPath:path];
    if (isExist==NO) {
        NSError *error;
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            isSuccess = NO;
            NSLog(@"creat Directory Failed:%@",[error localizedDescription]);
        }else{
            // 建造数据文档 fileInfo
//            LocalFileInfoModel *localFileInfoModel = [[LocalFileInfoModel alloc] init];
//            NSString *fileInfoPath = [path stringByAppendingPathComponent:@"fileInfo.archive"];
//            [NSKeyedArchiver archiveRootObject:localFileInfoModel toFile:fileInfoPath];
            
        }
    }
    return isSuccess;
}

#pragma mark - 拼接文件的路径
- (NSString*)jointFilePath:(NSString*)fileName{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDirectoryName = [NSString stringWithFormat:@"%@_%@",[Configure singletonInstance].currentProjectModel.projectId,[Configure singletonInstance].personInfoModel.username];
    NSString *fileDirectoryPath = [documentPath stringByAppendingPathComponent:fileDirectoryName];
    NSString *filePath = [fileDirectoryPath stringByAppendingPathComponent:fileName];
    return filePath;
    
}

#pragma mark - 往LocalFileInfoModel写进数据
- (void)writeDataInfoInLocalFileInfoModel:(LoadingFileModel*)saveLoadingFileModel{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDirectoryName = [NSString stringWithFormat:@"%@_%@",[Configure singletonInstance].currentProjectModel.projectId,[Configure singletonInstance].personInfoModel.username];
    NSString *fileDirectoryPath = [documentPath stringByAppendingPathComponent:fileDirectoryName];
    NSString *localFileInfoModelPath = [fileDirectoryPath stringByAppendingPathComponent:@"fileInfo.archive"];
    LocalFileInfoModel *localFileInfoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:localFileInfoModelPath];
    
    BOOL isExist = false;
    for (int a = 0; a < [localFileInfoModel.loadingFileModelMutableArray count]; a++) {
        LoadingFileModel *loadingFileModel = localFileInfoModel.loadingFileModelMutableArray[a];
        if ([loadingFileModel.fileId isEqualToString:saveLoadingFileModel.fileId]) {
            isExist = true;
            break;
        }
    }
    if (!isExist) {
        [localFileInfoModel.loadingFileModelMutableArray addObject:saveLoadingFileModel];
        [NSKeyedArchiver archiveRootObject:localFileInfoModel toFile:localFileInfoModelPath];
    }
}

@end
