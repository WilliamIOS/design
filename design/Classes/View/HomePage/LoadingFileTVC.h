//
//  LoadingFileTVC.h
//  design
//
//  Created by panwei on 2020/7/9.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "LoadingFileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoadingFileTVC : UITableViewCell

@property (nonatomic,assign) ViewControllerType viewControllerType;

@property (nonatomic,strong) LoadingFileModel *loadingFileModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
