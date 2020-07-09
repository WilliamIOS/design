//
//  LoadingFileTVC.m
//  design
//
//  Created by panwei on 2020/7/9.
//

#import "LoadingFileTVC.h"

@interface LoadingFileTVC()

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIImageView *fileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fileTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *loadingBtn;
@property (weak, nonatomic) IBOutlet UIButton *transmitBtn;


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
    
}

@end
