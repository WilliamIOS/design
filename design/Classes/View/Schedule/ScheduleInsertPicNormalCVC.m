//
//  ScheduleInsertPicNormalCVC.m
//  design
//
//  Created by panwei on 7/24/20.
//

#import "ScheduleInsertPicNormalCVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Macro.h"

@interface ScheduleInsertPicNormalCVC()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic,strong) AVPlayerViewController *playerViewController;

@end

@implementation ScheduleInsertPicNormalCVC

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setUploadMediaModel:(UploadMediaModel *)uploadMediaModel{
    _uploadMediaModel = uploadMediaModel;
    if ([uploadMediaModel.mediaType isEqualToString:@"0"]) {
        self.imgView.hidden = false;
        self.imgView.image = [UIImage imageWithData:uploadMediaModel.picImageData];

        NSArray *subViewsArray =   [self.contentView subviews];
        NSMutableArray *deleteView = [NSMutableArray array];
        for (int a = 0; a < [subViewsArray count]; a++) {
            UIView *sub = subViewsArray[a];
            if (![sub isKindOfClass:UIImageView.class]) {
                [deleteView addObject:sub];
            }
        }
        
        for (int b = 0; b < [deleteView count]; b++) {
            UIView *sub = deleteView[b];
            [sub removeFromSuperview];
        }
        
        
    }else if ([uploadMediaModel.mediaType isEqualToString:@"1"]){
        self.imgView.hidden = true;
        _playerViewController = [[AVPlayerViewController alloc] init];
        AVPlayer *avPlayer= [AVPlayer playerWithURL:self.uploadMediaModel.videoUrl];
        _playerViewController.player = avPlayer;
        
        // 试图的填充模式
        _playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
        // 是否显示播放控制条
        [self.contentView addSubview:self.playerViewController.view];
        CGFloat width = (currentScreenW - 20*2 - 10*2) / 3;
        _playerViewController.view.frame = CGRectMake(0, 0, width,width);
        // 播放
        [_playerViewController.player play];
    }else{
        
    }
}

- (void)setUploadMediaDetailModel:(UploadMediaModel *)uploadMediaDetailModel{
    _uploadMediaDetailModel = uploadMediaDetailModel;
    if ([uploadMediaDetailModel.mediaType isEqualToString:@"0"]) {
        self.imgView.hidden = false;

        NSArray *subViewsArray =   [self.contentView subviews];
        NSMutableArray *deleteView = [NSMutableArray array];
        for (int a = 0; a < [subViewsArray count]; a++) {
            UIView *sub = subViewsArray[a];
            if (![sub isKindOfClass:UIImageView.class]) {
                [deleteView addObject:sub];
            }
        }
        
        for (int b = 0; b < [deleteView count]; b++) {
            UIView *sub = deleteView[b];
            [sub removeFromSuperview];
        }
        
        NSString *url = uploadMediaDetailModel.mediaUrl;
        if (![url isEqualToString:@""] && url != nil) {
        NSString * urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error != nil) {
                    /**下载失败*/
                    
                }else{
                    /**下载成功*/
                    self.imgView.image = image;
                    self.uploadMediaDetailModel.picImageData =  UIImageJPEGRepresentation(image, 0.7);
                }
            }];
        }
        
    }else if ([uploadMediaDetailModel.mediaType isEqualToString:@"1"]){
        self.imgView.hidden = true;
        self.playerViewController = [[AVPlayerViewController alloc] init];
        AVPlayer *avPlayer= [AVPlayer playerWithURL:[NSURL URLWithString:uploadMediaDetailModel.mediaUrl]];
        self.playerViewController.player = avPlayer;
        
        // 试图的填充模式
        self.playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
        // 是否显示播放控制条
        [self.contentView addSubview:self.playerViewController.view];
        CGFloat width = (currentScreenW - 20*2 - 10*2) / 3;
        self.playerViewController.view.frame = CGRectMake(0, 0, width,width);
        // 播放
        [self.playerViewController.player play];
        
    }else{
        
    }
}

#pragma mark - 文件下载
- (void)fileLoading:(UploadMediaModel*)uploadMediaModel{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString * urlStr = [uploadMediaModel.mediaUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 获取tmp目录
        NSString *tmpPath = NSTemporaryDirectory();
        NSString *path = [tmpPath stringByAppendingPathComponent:uploadMediaModel.mediaUrl];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error == nil) {
            uploadMediaModel.videoUrl = filePath;
            uploadMediaModel.videoImage =  [uploadMediaModel getVideoImageWithTime:1.0 videoPath:uploadMediaModel.videoUrl];
            self.imgView.image = uploadMediaModel.videoImage;
        }

    }];
    // 4. 开启下载任务
    [downloadTask resume];
}

@end
