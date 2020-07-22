//
//  ScheduleDetailHeaderTVC.h
//  design
//
//  Created by panwei on 7/22/20.
//

#import <UIKit/UIKit.h>
#import "ChangeScheduleListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleDetailHeaderTVC : UITableViewCell

@property (nonatomic,strong) ChangeScheduleListModel *changeScheduleListModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
