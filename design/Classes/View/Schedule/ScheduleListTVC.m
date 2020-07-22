//
//  ScheduleListTVC.m
//  design
//
//  Created by panwei on 7/21/20.
//

#import "ScheduleListTVC.h"

@interface ScheduleListTVC()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation ScheduleListTVC

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
    ScheduleListTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[ScheduleListTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}


- (void)setChangeScheduleListModel:(ChangeScheduleListModel *)changeScheduleListModel{
    _changeScheduleListModel = changeScheduleListModel;
    self.titleLabel.text = changeScheduleListModel.scheduleName;
    self.timeLabel.text = changeScheduleListModel.createDate;
}

@end
