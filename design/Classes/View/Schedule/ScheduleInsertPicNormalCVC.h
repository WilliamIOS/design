//
//  ScheduleInsertPicNormalCVC.h
//  design
//
//  Created by panwei on 7/24/20.
//

#import <UIKit/UIKit.h>
#import "UploadMediaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleInsertPicNormalCVC : UICollectionViewCell

@property (nonatomic,strong) UploadMediaModel *uploadMediaModel;
@property (nonatomic,strong) UploadMediaModel *uploadMediaDetailModel;

@end

NS_ASSUME_NONNULL_END
