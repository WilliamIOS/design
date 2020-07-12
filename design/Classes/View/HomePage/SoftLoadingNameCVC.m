//
//  SoftLoadingNameCVC.m
//  design
//
//  Created by panwei on 7/10/20.
//

#import "SoftLoadingNameCVC.h"
#import "Macro.h"

@interface SoftLoadingNameCVC()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation SoftLoadingNameCVC

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath{
    _currentIndexPath = currentIndexPath;
    if (currentIndexPath.item == 0 || currentIndexPath.item == 3 || currentIndexPath.item == 4 || currentIndexPath.item == 7 || currentIndexPath.item == 8 || currentIndexPath.item == 11 || currentIndexPath.item == 12 || currentIndexPath.item == 15 || currentIndexPath.item == 16 || currentIndexPath.item == 19) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }else{
        self.contentView.backgroundColor = PWColor(255, 243, 253);
    }
}

@end
