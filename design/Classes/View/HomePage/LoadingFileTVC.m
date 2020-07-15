//
//  LoadingFileTVC.m
//  design
//
//  Created by panwei on 2020/7/9.
//

#import "LoadingFileTVC.h"
#import "UIViewController+Extension.h"
#import "MBProgressHUD+PW.h"

@interface LoadingFileTVC()

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIImageView *fileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fileTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *transmitBtn;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;

@end

@implementation LoadingFileTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupSetings];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName{
    NSString *cellidentifier = cellidentifierName;
    LoadingFileTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[LoadingFileTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setupSetings{
    [self.checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.transmitBtn addTarget:self action:@selector(transmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.transmitBtn setTitle:@"" forState:UIControlStateNormal];
    
}

- (void)setLoadingFileModel:(LoadingFileModel *)loadingFileModel{
    _loadingFileModel = loadingFileModel;
    self.fileTitleLabel.text = loadingFileModel.documentName;
    self.timeLable.text = loadingFileModel.createDate;
    // 记录文件后缀名
    if ([loadingFileModel.documentName containsString:@"."]) {
         NSArray *documentNameArray = [loadingFileModel.documentName componentsSeparatedByString:@"."];
        NSInteger count =  [documentNameArray count];
        loadingFileModel.fileSuffixStr = documentNameArray[count - 1];

    }else{
        loadingFileModel.fileSuffixStr = @"";
    }
    if ([loadingFileModel.fileSuffixStr isEqualToString:@"pdf"]) {
        self.fileImageView.image = [UIImage imageNamed:@"pdf"];
        
    }else if ([loadingFileModel.fileSuffixStr isEqualToString:@"dwg"]) {
        self.fileImageView.image = [UIImage imageNamed:@"cad"];
        
    }else if ([loadingFileModel.fileSuffixStr isEqualToString:@"rar"]) {
        self.fileImageView.image = [UIImage imageNamed:@"rar"];
        
    }else{
        self.fileImageView.image = [UIImage imageNamed:@"otherFile"];
    }
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachesPath stringByAppendingPathComponent:loadingFileModel.documentName];
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL pathHave = [manager fileExistsAtPath:path];
    if (pathHave) {
        [self.transmitBtn setTitle:@"转发" forState:UIControlStateNormal];
    }else{
        [self.transmitBtn setTitle:@"下载" forState:UIControlStateNormal];
    }
    
    self.checkBtn.selected = self.loadingFileModel.isChecked;
}

- (void)checkBtnClick:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    self.loadingFileModel.isChecked = btn.selected;
}

- (void)previewBtnClick:(id)sender{
    [self.delegate didpreviewBtn:self.loadingFileModel currentIndexPath:self.currentIndexPath];
}

- (void)transmitBtnClick:(id)sender{
    UIButton *btn = (UIButton*)sender;
    if ([btn.titleLabel.text isEqualToString:@"下载"]) {
        UIViewController *topViewController = [UIViewController topViewController];
        [MBProgressHUD showChrysanthemumWithView:topViewController.view hintMsg:@"下载中" delegateTarget:topViewController];
        [self.loadingFileModel fileLoading:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:topViewController.view];
            if (error == nil) {
                [btn setTitle:@"转发" forState:UIControlStateNormal];
            }else{
                
            }
        }];
        
    }else if ([btn.titleLabel.text isEqualToString:@"转发"]){
        [self share];
        
    }else{
        
    }
}

- (void)share{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachesPath stringByAppendingPathComponent:self.loadingFileModel.documentName];
//    NSString *path  = [[NSBundle mainBundle] pathForResource:@"sharing" ofType:@"zip"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSArray *activityItems = @[fileURL];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //不出现在活动项目
    if (@available(iOS 11.0, *)) {
        activityVC.excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFacebook,UIActivityTypePostToWeibo,UIActivityTypePostToTwitter,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks,UIActivityTypeMarkupAsPDF,UIActivityTypeCopyToPasteboard];
        
    } else {
        // Fallback on earlier versions
        activityVC.excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFacebook,UIActivityTypePostToWeibo,UIActivityTypePostToTwitter,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeCopyToPasteboard];
    }
    UIViewController *topViewController = [UIViewController topViewController];
    [topViewController presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            //分享 成功
        } else  {
            //分享 取消
        }
    };
}

@end
