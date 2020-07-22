//
//  ScheduleDetailHeaderTVC.m
//  design
//
//  Created by panwei on 7/22/20.
//

#import "ScheduleDetailHeaderTVC.h"

@interface ScheduleDetailHeaderTVC()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *designerLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateDetailLabel;

@end

@implementation ScheduleDetailHeaderTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName{
    NSString *cellidentifier = cellidentifierName;
    ScheduleDetailHeaderTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[ScheduleDetailHeaderTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setChangeScheduleListModel:(ChangeScheduleListModel *)changeScheduleListModel{
    _changeScheduleListModel = changeScheduleListModel;
    self.titleLabel.text = changeScheduleListModel.scheduleName;
    self.updateTimeLabel.text = changeScheduleListModel.createDate;
    self.designerLabel.text = changeScheduleListModel.changeName;
    self.updateDetailLabel.text = changeScheduleListModel.changeDetails;
}

@end
