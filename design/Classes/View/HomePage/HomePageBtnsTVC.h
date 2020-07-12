//
//  HomePageBtnsTVC.h
//  design
//
//  Created by panwei on 2020/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomePageBtnsTVCDelegate <NSObject>

- (void)didConceptSchemeBtn;
- (void)didSoftLoadingBtn;

@end

@interface HomePageBtnsTVC : UITableViewCell

@property (nonatomic, assign) id<HomePageBtnsTVCDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName;

@end

NS_ASSUME_NONNULL_END
