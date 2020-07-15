//
//  PlanListTVC.h
//  design
//
//  Created by panwei on 7/12/20.
//

#import <UIKit/UIKit.h>
#import "ScheduleListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlanListTVC : UITableViewCell

@property (nonatomic,strong) ScheduleListModel *scheduleListModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
