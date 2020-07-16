//
//  HomePageBtnsTVC.m
//  design
//
//  Created by panwei on 2020/7/7.
//

#import "HomePageBtnsTVC.h"
#import "UIView+Extension.h"
#import "Configure.h"
#import "LoadingFileModel.h"

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


@property (weak, nonatomic) IBOutlet UIView *remindStutasConceptSchemeView;
@property (weak, nonatomic) IBOutlet UIView *remindStutasPlaneFigureView;
@property (weak, nonatomic) IBOutlet UIView *remindStutasDesignSketchView;
@property (weak, nonatomic) IBOutlet UIView *remindStutasConstructionPlansView;

@property (weak, nonatomic) IBOutlet UIView *remindStutasSoftLoadingView;
@property (weak, nonatomic) IBOutlet UIView *remindStutasOtherFileView;

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
    
    [self.remindStutasConceptSchemeView setRoundedView:self.remindStutasConceptSchemeView cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor]];
    [self.remindStutasPlaneFigureView setRoundedView:self.remindStutasPlaneFigureView cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor]];
    [self.remindStutasDesignSketchView setRoundedView:self.remindStutasDesignSketchView cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor]];
    [self.remindStutasConstructionPlansView setRoundedView:self.remindStutasConstructionPlansView cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor]];
    [self.remindStutasSoftLoadingView setRoundedView:self.remindStutasSoftLoadingView cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor]];
    [self.remindStutasOtherFileView setRoundedView:self.remindStutasOtherFileView cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor]];
    
    self.remindStutasConceptSchemeView.hidden = true;
    self.remindStutasPlaneFigureView.hidden = true;
    self.remindStutasDesignSketchView.hidden = true;
    self.remindStutasConstructionPlansView.hidden = true;
    self.remindStutasSoftLoadingView.hidden = true;
    self.remindStutasOtherFileView.hidden = true;
}

- (void)conceptSchemeBtnClick:(id)sender{
    [self.delegate didConceptSchemeBtn];
}

- (void)planeFigureBtnClick:(id)sender{
    [self.delegate didPlaneFigureBtn];
}

- (void)designSketchBtnClick:(id)sender{
    [self.delegate didDesignSketchBtn];
}

- (void)constructionPlansBtnClick:(id)sender{
    [self.delegate didConstructionPlansBtn];
}

- (void)softLoadingBtnClick:(id)sender{
    [self.delegate didSoftLoadingBtn];
}

- (void)otherFileBtnClick:(id)sender{
    [self.delegate didOtherFileBtn];
}

- (void)allLoadingBtnClick:(id)sender{
    [self.delegate didAllLoadingBtn];
}

- (void)conceptSchemePreviewImageViewGesture:(UITapGestureRecognizer*)recognizer {
    [self.delegate didConceptSchemePreviewImageViewPreview];
}

- (void)planeFigurePreviewImageViewGesture:(UITapGestureRecognizer*)recognizer {
    [self.delegate didPlaneFigurePreviewImageViewPreview];
}

- (void)designSketchPreviewImageViewGesture:(UITapGestureRecognizer*)recognizer {
    [self.delegate didDesignSketchPreviewImageViewPreview];
}

- (void)setRefresh:(BOOL)refresh{
    _refresh = refresh;
    NSMutableArray *remindDataMutableArray = [Configure singletonInstance].remindDataMutableArray;
    
    NSMutableArray *remindCopyDataMutableArray = [remindDataMutableArray mutableCopy];
    for (int i = 0; i < [remindDataMutableArray count]; i++) {
        LoadingFileModel *loadingFileModel = remindDataMutableArray[i];
        if ([loadingFileModel.updateName isEqualToString:@"概念方案文本"]) {
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStutasConceptSchemeView.hidden = false;
            }else{
                self.remindStutasConceptSchemeView.hidden = true;
            }
            
        }else if ([loadingFileModel.updateName isEqualToString:@"平面图"]){
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStutasPlaneFigureView.hidden = false;
            }else{
                self.remindStutasPlaneFigureView.hidden = true;
            }
            
        }else if ([loadingFileModel.updateName isEqualToString:@"效果图"]){
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStutasDesignSketchView.hidden = false;
            }else{
                self.remindStutasDesignSketchView.hidden = true;
            }
            
        }else if ([loadingFileModel.updateName isEqualToString:@"施工文件"]){
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStutasConstructionPlansView.hidden = false;
                
            }else{
                BOOL flatSurfaceRemind = false;
                BOOL partitionRemind = false;
                BOOL diagramRemind = false;
                for (int a = 0; a < [remindCopyDataMutableArray count]; a++) {
                    LoadingFileModel *loadingCopyFileModel = remindCopyDataMutableArray[a];
                    if ([loadingCopyFileModel.updateName isEqualToString:@"施工平顶面"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        flatSurfaceRemind = true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"隔墙图"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        partitionRemind = true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"水电图"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        diagramRemind = true;
                    }else{
                        
                    }
                }
                
                if (flatSurfaceRemind || partitionRemind || diagramRemind) {
                   self.remindStutasConstructionPlansView.hidden = false;
                }else{
                    self.remindStutasConstructionPlansView.hidden = true;
                }
            }
            
        }else if ([loadingFileModel.updateName isEqualToString:@"软装及材料"]){
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStutasSoftLoadingView.hidden = false;
            }else{
                BOOL total = false;
                for (int a = 0; a < [remindCopyDataMutableArray count]; a++) {
                    LoadingFileModel *loadingCopyFileModel = remindCopyDataMutableArray[a];
                    if ([loadingCopyFileModel.updateName isEqualToString:@"家具清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"装饰灯具清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"工程灯具清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"软装清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"窗帘清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"五金清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"洁具清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"主材清单"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"材料样板"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"定制家具CAD图纸"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"花灯深化CAD图纸"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"工程灯具点位CAD图纸"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"定制艺术品图纸"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else if ([loadingCopyFileModel.updateName isEqualToString:@"图纸变更"] && [loadingCopyFileModel.status isEqualToString:@"1"]) {
                        total =  total || true;
                    }else{
                        
                    }
                }
                
                if (total) {
                    self.remindStutasSoftLoadingView.hidden = false;
                }else{
                    self.remindStutasSoftLoadingView.hidden = true;
                }
                
            }
            
        }else if ([loadingFileModel.updateName isEqualToString:@"其他文件"]){
            if ([loadingFileModel.status isEqualToString:@"1"]) {
                self.remindStutasOtherFileView.hidden = false;
            }else{
                self.remindStutasOtherFileView.hidden = true;
            }
        }else{
            
        }
    }
    
}

@end
