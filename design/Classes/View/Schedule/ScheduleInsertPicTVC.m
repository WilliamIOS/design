//
//  ScheduleInsertPicTVC.m
//  design
//
//  Created by panwei on 7/24/20.
//

#import "ScheduleInsertPicTVC.h"
#import "ScheduleInsertPicNormalCVC.h"
#import "Macro.h"
#import "ImageDetailVC.h"
#import "VedioDetailVC.h"
#import "UIViewController+Extension.h"


@interface ScheduleInsertPicTVC()<UICollectionViewDelegate
,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *picCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picCVConstraintH;
@property (nonatomic,assign) CGFloat picH;

@end

@implementation ScheduleInsertPicTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupSettings];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName{
    NSString *cellidentifier = cellidentifierName;
    ScheduleInsertPicTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[ScheduleInsertPicTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setupSettings{
    self.picCollectionView.delegate = self;
    self.picCollectionView.dataSource = self;
}

- (void)setPicMutableArray:(NSMutableArray *)picMutableArray{
    _picMutableArray = picMutableArray;
    [self.picCollectionView reloadData];
    [self.contentView layoutIfNeeded];
    self.picCVConstraintH.constant = self.picCollectionView.contentSize.height;
    // 刷新外部
//    NSNotification *notification =[NSNotification notificationWithName:@"ScheduleInsertVCRefreshNotification" object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

#pragma mark - CollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.picMutableArray count];
}

#pragma mark - CollectionViewDelegateFlowLayout(optional)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (currentScreenW - 20*2 - 10*2) / 3;
    CGSize size = CGSizeMake(width, width);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleInsertPicNormalCVC *scheduleInsertPicNormalCVC = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScheduleInsertPicNormalCVC" forIndexPath:indexPath];
    if ([self.reuseIdentifier isEqualToString:@"ScheduleInsertPicTVCWithScheduleInsert"]) {
        scheduleInsertPicNormalCVC.uploadMediaModel = self.picMutableArray[indexPath.item];
    }else if ([self.reuseIdentifier isEqualToString:@"ScheduleInsertPicTVCWithScheduleDetail"]){
        scheduleInsertPicNormalCVC.uploadMediaDetailModel = self.picMutableArray[indexPath.item];
    }else{
        
    }
    
    return scheduleInsertPicNormalCVC;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.reuseIdentifier isEqualToString:@"ScheduleInsertPicTVCWithScheduleInsert"]) {
        if (indexPath.item == [self.picMutableArray count] -1) {
            NSNotification *notification =[NSNotification notificationWithName:@"RequestInsertPic" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }else{
            UploadMediaModel *uploadMediaModel = self.picMutableArray[indexPath.item];
            UIViewController *topVC = [UIViewController topViewController];
            
            if ([uploadMediaModel.mediaType isEqualToString:@"0"]) {
                ImageDetailVC *imageDetailVC = [topVC.storyboard instantiateViewControllerWithIdentifier:@"ImageDetailVC"];
                imageDetailVC.imgData = uploadMediaModel.picImageData;
                UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
                topVC.navigationItem.backBarButtonItem = item;
                [topVC.navigationController pushViewController:imageDetailVC animated:true];
                
            }else if ([uploadMediaModel.mediaType isEqualToString:@"1"]){
//                VedioDetailVC *vedioDetailVC = [topVC.storyboard instantiateViewControllerWithIdentifier:@"VedioDetailVC"];
//                vedioDetailVC.comeFrom = @"ScheduleInsertPicTVCWithScheduleInsert";
//                vedioDetailVC.uploadMediaModel = uploadMediaModel;
//                UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//                topVC.navigationItem.backBarButtonItem = item;
//                [topVC.navigationController pushViewController:vedioDetailVC animated:true];

            }else{
                
            }
        }
    }else if ([self.reuseIdentifier isEqualToString:@"ScheduleInsertPicTVCWithScheduleDetail"]){
        UploadMediaModel *uploadMediaModel = self.picMutableArray[indexPath.item];
        UIViewController *topVC = [UIViewController topViewController];
        
        if ([uploadMediaModel.mediaType isEqualToString:@"0"]) {
            ImageDetailVC *imageDetailVC = [topVC.storyboard instantiateViewControllerWithIdentifier:@"ImageDetailVC"];
            imageDetailVC.imgData = uploadMediaModel.picImageData;
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            topVC.navigationItem.backBarButtonItem = item;
            [topVC.navigationController pushViewController:imageDetailVC animated:true];
            
        }else if ([uploadMediaModel.mediaType isEqualToString:@"1"]){
//            VedioDetailVC *vedioDetailVC = [topVC.storyboard instantiateViewControllerWithIdentifier:@"VedioDetailVC"];
//            vedioDetailVC.comeFrom = @"ScheduleInsertPicTVCWithScheduleDetail";
//            vedioDetailVC.uploadMediaModel = uploadMediaModel;
//            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//            topVC.navigationItem.backBarButtonItem = item;
//            [topVC.navigationController pushViewController:vedioDetailVC animated:true];

        }else{
            
        }
    }else{
        
    }
    
    
    
}

@end
