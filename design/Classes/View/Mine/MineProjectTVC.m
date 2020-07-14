//
//  MineProjectTVC.m
//  design
//
//  Created by panwei on 2020/7/7.
//

#import "MineProjectTVC.h"
#import "UIView+Extension.h"

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
    
}

@end
