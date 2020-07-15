//
//  PlanListTVC.m
//  design
//
//  Created by panwei on 7/12/20.
//

#import "PlanListTVC.h"

@interface PlanListTVC()

@property (weak, nonatomic) IBOutlet UILabel *planTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *planTimeLabel;

@end

@implementation PlanListTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.planTitleLabel.text =@"";
    self.planTimeLabel.text =@"计划周期：";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName{
    NSString *cellidentifier = cellidentifierName;
    PlanListTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[PlanListTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setScheduleListModel:(ScheduleListModel *)scheduleListModel{
    _scheduleListModel = scheduleListModel;
    self.planTitleLabel.text = scheduleListModel.workContent;
    self.planTimeLabel.text = [NSString stringWithFormat:@"计划周期：%@",scheduleListModel.planningTime];
    
}

@end
