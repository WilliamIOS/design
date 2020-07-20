//
//  MineProjectTVC.m
//  design
//
//  Created by panwei on 2020/7/7.
//

#import "MineProjectTVC.h"
#import "UIView+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MineProjectTVC()

@property (weak, nonatomic) IBOutlet UIView *imageBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectTimeLabel;

@end

@implementation MineProjectTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupSettings];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName{
    NSString *cellidentifier = cellidentifierName;
    MineProjectTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[MineProjectTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setupSettings{
    [self.imageBackgroundView setRoundedView:self.imageBackgroundView cornerRadius:8 borderWidth:0.5 borderColor:[UIColor lightGrayColor]];
    [self.projectImageView setRoundedView:self.projectImageView cornerRadius:8 borderWidth:0.5 borderColor:[UIColor clearColor]];
}

- (void)setProjectModel:(ProjectModel *)projectModel{
    _projectModel = projectModel;
    self.projectTitleLabel.text = projectModel.projectName;
    NSArray *createDateArray = [projectModel.createDate componentsSeparatedByString:@" "];
    self.projectTimeLabel.text = createDateArray[0];
    NSString *url = projectModel.imageAddress;
    if (![url isEqualToString:@""] && url != nil) {
    NSString * urlStr = [projectModel.imageAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"topListImg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error != nil) {
                /**下载失败*/
                self.projectImageView.image = [UIImage imageNamed:@"topListImg"];
            }else{
                /**下载成功*/
                self.projectImageView.image = image;
            }
        }];
    }
}

@end
