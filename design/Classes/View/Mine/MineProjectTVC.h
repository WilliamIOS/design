//
//  MineProjectTVC.h
//  design
//
//  Created by panwei on 2020/7/7.
//

#import <UIKit/UIKit.h>
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineProjectTVC : UITableViewCell

@property (nonatomic,strong) ProjectModel *projectModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
