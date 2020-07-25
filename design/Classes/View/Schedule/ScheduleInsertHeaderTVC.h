//
//  ScheduleInsertHeaderTVC.h
//  design
//
//  Created by panwei on 7/24/20.
//

#import <UIKit/UIKit.h>
#import "ScheduleInsertModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleInsertHeaderTVC : UITableViewCell

@property (nonatomic,strong) ScheduleInsertModel *scheduleInsertModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
