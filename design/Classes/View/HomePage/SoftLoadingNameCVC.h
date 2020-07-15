//
//  SoftLoadingNameCVC.h
//  design
//
//  Created by panwei on 7/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SoftLoadingNameCVC : UICollectionViewCell

@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@property (nonatomic,strong) NSMutableArray *dataMutableArray;
@property (nonatomic,strong) NSString *btnNameStr;


@end

NS_ASSUME_NONNULL_END
