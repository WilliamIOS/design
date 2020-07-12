//
//  ProjectScheduleTVC.h
//  design
//
//  Created by panwei on 7/9/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProjectScheduleTVCDelegate <NSObject>

- (void)didscheduleCalendarBtn;

@end

@interface ProjectScheduleTVC : UITableViewCell

@property (nonatomic, assign) id<ProjectScheduleTVCDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
