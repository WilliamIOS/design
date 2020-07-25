//
//  VedioDetailVC.m
//  design
//
//  Created by panwei on 7/24/20.
//

#import "VedioDetailVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Macro.h"

@interface VedioDetailVC ()

@property (nonatomic,strong) AVPlayerViewController *playerViewController;

@end

@implementation VedioDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"详情";
    self.playerViewController = [[AVPlayerViewController alloc] init];
    if ([self.comeFrom isEqualToString:@"ScheduleInsertPicTVCWithScheduleInsert"]) {
        AVPlayer *avPlayer= [AVPlayer playerWithURL:self.uploadMediaModel.videoUrl];
        self.playerViewController.player = avPlayer;
    }else if ([self.comeFrom isEqualToString:@"ScheduleInsertPicTVCWithScheduleDetail"]){
        AVPlayer *avPlayer= [AVPlayer playerWithURL:[NSURL URLWithString:self.uploadMediaModel.mediaUrl]];
        self.playerViewController.player = avPlayer;
    }else{
        
    }
    
    // 试图的填充模式
    self.playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    // 是否显示播放控制条
    self.playerViewController.showsPlaybackControls = YES;
    [self.view addSubview:self.playerViewController.view];
    self.playerViewController.view.frame = CGRectMake(0, 0, currentScreenW,currentScreenH);
    // 播放
    [self.playerViewController.player play];
}


@end
