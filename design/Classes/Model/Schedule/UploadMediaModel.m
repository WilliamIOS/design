//
//  UploadMediaModel.m
//  design
//
//  Created by panwei on 7/24/20.
//

#import "UploadMediaModel.h"
#import <AVFoundation/AVFoundation.h>

@implementation UploadMediaModel

/**

 获取视频的 某一帧
 @paramcurrentTime 某一时刻单位 s
 @parampath 视频路径
 @returnreturn 返回image
 */
- (UIImage*)getVideoImageWithTime:(Float64)currentTime videoPath:(NSURL*)path{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError*error =nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

@end
