//
//  AddressBookListHeaderTVC.h
//  design
//
//  Created by panwei on 7/23/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookListHeaderTVC : UITableViewCell

@property (nonatomic,strong) NSIndexPath *currentIndexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
