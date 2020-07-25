//
//  VedioDetailVC.h
//  design
//
//  Created by panwei on 7/24/20.
//

#import <UIKit/UIKit.h>
#import "UploadMediaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VedioDetailVC : UIViewController
// 
@property (nonatomic,strong) NSString *comeFrom;

@property (nonatomic,strong) UploadMediaModel *uploadMediaModel;

@end

NS_ASSUME_NONNULL_END
