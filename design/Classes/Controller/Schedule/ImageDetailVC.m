//
//  ImageDetailVC.m
//  design
//
//  Created by panwei on 7/24/20.
//

#import "ImageDetailVC.h"

@interface ImageDetailVC ()

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;


@end

@implementation ImageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"详情";
    self.detailImageView.image = [UIImage imageWithData:self.imgData];
}


@end
