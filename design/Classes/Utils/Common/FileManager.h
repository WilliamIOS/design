//
//  FileManager.h
//  design
//
//  Created by panwei on 7/23/20.
//

#import <Foundation/Foundation.h>
#import "LoadingFileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileManager : NSObject

/**创建文件夹*/
- (BOOL)creatDir:(NSString *)path;
/**拼接文件路径*/
- (NSString*)jointFilePath:(NSString*)fileName;
/**往LocalFileInfoModel写进数据*/
- (void)writeDataInfoInLocalFileInfoModel:(LoadingFileModel*)saveLoadingFileModel;

@end

NS_ASSUME_NONNULL_END
