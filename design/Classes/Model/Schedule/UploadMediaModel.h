//
//  UploadMediaModel.h
//  design
//
//  Created by panwei on 7/24/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadMediaModel : NSObject
// 0:图片 1:视频 2:空白 占位
@property (nonatomic,strong) NSString *mediaType;
// 图片相关
@property (nonatomic,strong) NSData *picImageData;
// 视频相关
@property (nonatomic,strong) NSURL *videoUrl;
@property (nonatomic,strong) UIImage *videoImage;
// 成功回调
@property (nonatomic,strong) NSString *sucData;



/*************************第二套逻辑************************/
@property (nonatomic,strong) NSString *mediaUrl;

- (UIImage*)getVideoImageWithTime:(Float64)currentTime videoPath:(NSURL*)path;


@end

NS_ASSUME_NONNULL_END
