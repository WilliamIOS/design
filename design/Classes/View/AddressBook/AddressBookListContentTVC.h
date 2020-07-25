//
//  AddressBookListContentTVC.h
//  design
//
//  Created by panwei on 7/23/20.
//

#import <UIKit/UIKit.h>
#import "AddressBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookListContentTVC : UITableViewCell

@property (nonatomic,strong) AddressBookModel *addressBookModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
