//
//  LoginTableViewController.h
//  design
//
//  Created by panwei on 2020/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ SuccessBlock)(id responseBody);
typedef void(^ FailureBlock)(id error);

@interface LoginTableViewController : UITableViewController

@end

NS_ASSUME_NONNULL_END
