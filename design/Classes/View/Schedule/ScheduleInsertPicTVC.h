//
//  ScheduleInsertPicTVC.h
//  design
//
//  Created by panwei on 7/24/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleInsertPicTVC : UITableViewCell

@property (nonatomic,strong) NSMutableArray *picMutableArray;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
