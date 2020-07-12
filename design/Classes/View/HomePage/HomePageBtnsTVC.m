//
//  HomePageBtnsTVC.m
//  design
//
//  Created by panwei on 2020/7/7.
//

#import "HomePageBtnsTVC.h"

@interface HomePageBtnsTVC()

// 概念方案 preview
@property (weak, nonatomic) IBOutlet UIButton *conceptSchemeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *conceptSchemePreviewImageView;
// 平面图
@property (weak, nonatomic) IBOutlet UIButton *planeFigureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *planeFigurePreviewImageView;
// 效果图
@property (weak, nonatomic) IBOutlet UIButton *designSketchBtn;
@property (weak, nonatomic) IBOutlet UIImageView *designSketchPreviewImageView;
// 施工图
@property (weak, nonatomic) IBOutlet UIButton *constructionPlansBtn;
// 软装材料
@property (weak, nonatomic) IBOutlet UIButton *softLoadingBtn;
// 其他文件
@property (weak, nonatomic) IBOutlet UIButton *otherFileBtn;
// 一键下载
@property (weak, nonatomic) IBOutlet UIButton *allLoadingBtn;


@end

@implementation HomePageBtnsTVC


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
    HomePageBtnsTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[HomePageBtnsTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setupSettings{
    [self.conceptSchemeBtn addTarget:self action:@selector(conceptSchemeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.planeFigureBtn addTarget:self action:@selector(planeFigureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.designSketchBtn addTarget:self action:@selector(designSketchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.constructionPlansBtn addTarget:self action:@selector(constructionPlansBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.softLoadingBtn addTarget:self action:@selector(softLoadingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.otherFileBtn addTarget:self action:@selector(otherFileBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.allLoadingBtn addTarget:self action:@selector(allLoadingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.conceptSchemePreviewImageView.userInteractionEnabled = true;
    self.planeFigurePreviewImageView.userInteractionEnabled = true;
    self.designSketchPreviewImageView.userInteractionEnabled = true;
    
    UITapGestureRecognizer *conceptSchemePreviewImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(conceptSchemePreviewImageViewGesture:)];
    [self.conceptSchemePreviewImageView addGestureRecognizer:conceptSchemePreviewImageViewTap];
    
    UITapGestureRecognizer *planeFigurePreviewImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(planeFigurePreviewImageViewGesture:)];
    [self.planeFigurePreviewImageView addGestureRecognizer:planeFigurePreviewImageViewTap];
    
    UITapGestureRecognizer *designSketchPreviewImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(designSketchPreviewImageViewGesture:)];
    [self.designSketchPreviewImageView addGestureRecognizer:designSketchPreviewImageViewTap];
}

- (void)conceptSchemeBtnClick:(id)sender{
    [self.delegate didConceptSchemeBtn];
}

- (void)planeFigureBtnClick:(id)sender{
    
}

- (void)designSketchBtnClick:(id)sender{
    
}

- (void)constructionPlansBtnClick:(id)sender{
    
}

- (void)softLoadingBtnClick:(id)sender{
    [self.delegate didSoftLoadingBtn];
}

- (void)otherFileBtnClick:(id)sender{
    
}

- (void)allLoadingBtnClick:(id)sender{
    
}

- (void)conceptSchemePreviewImageViewGesture:(UITapGestureRecognizer*)recognizer {
    
}

- (void)planeFigurePreviewImageViewGesture:(UITapGestureRecognizer*)recognizer {
    
}

- (void)designSketchPreviewImageViewGesture:(UITapGestureRecognizer*)recognizer {
    
}


@end
