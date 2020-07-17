//
//  SoftLoadingListVC.m
//  design
//
//  Created by panwei on 7/10/20.
//

#import "SoftLoadingListVC.h"
#import "SoftLoadingNameCVC.h"
#import "UIView+Extension.h"
#import "Macro.h"
#import "MJRefresh.h"
#import "MBProgressHUD+PW.h"
#import "NetworkRequest.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "ResponseObjectModel.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "LoadingFileModel.h"
#import <QuickLook/QuickLook.h>
#import "SoftLoadingAllListVC.h"

@interface SoftLoadingListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *fileNameListCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *allSoftLoadingFileBtn;

@property (nonatomic,strong) NSMutableArray *dataMutableArray;
@property (nonatomic,strong) NSMutableArray *btnNameMutableArray;

@end

@implementation SoftLoadingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self decorationListInterface];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.fileNameListCollectionView.delegate = self;
    self.fileNameListCollectionView.dataSource = self;
    [self.allSoftLoadingFileBtn addTarget:self action:@selector(allSoftLoadingFileBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSMutableArray*)btnNameMutableArray{
    if (!_btnNameMutableArray) {
        self.btnNameMutableArray = [NSMutableArray array];
    }
    return _btnNameMutableArray;
}

- (NSMutableArray*)dataMutableArray{
    if (!_dataMutableArray) {
        self.dataMutableArray = [NSMutableArray array];
    }
    return _dataMutableArray;
}

- (void)allSoftLoadingFileBtnClick:(id)sender{
    SoftLoadingAllListVC *softLoadingAllListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SoftLoadingAllListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:softLoadingAllListVC animated:true];
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(currentScreenW*0.5, 50);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.btnNameMutableArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SoftLoadingNameCVC *softLoadingNameCVC = [collectionView dequeueReusableCellWithReuseIdentifier:@"SoftLoadingNameCVC" forIndexPath:indexPath];
    softLoadingNameCVC.currentIndexPath = indexPath;
    softLoadingNameCVC.dataMutableArray = self.dataMutableArray;
    softLoadingNameCVC.btnNameStr = self.btnNameMutableArray[indexPath.item];
    return softLoadingNameCVC;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - 文件列表
- (void)decorationListInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    [dic setObject:@"45" forKey:@"documentSort"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_DecorationList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            self.dataMutableArray = [LoadingFileModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (int i = 0; i < 16; i++) {
                if (i == 0) {
                    [self.btnNameMutableArray addObject:@"家具清单"];
                }else if (i == 1){
                    [self.btnNameMutableArray addObject:@"定制家具CAD图纸"];
                }else if (i == 2){
                    [self.btnNameMutableArray addObject:@"装饰灯具清单"];
                }else if (i == 3){
                    [self.btnNameMutableArray addObject:@"花灯深化CAD图纸"];
                }else if (i == 4){
                    [self.btnNameMutableArray addObject:@"工程灯具清单"];
                }else if (i == 5){
                    [self.btnNameMutableArray addObject:@"工程灯具点位CAD图纸"];
                }else if (i == 6){
                    [self.btnNameMutableArray addObject:@"软装清单"];
                }else if (i == 7){
                    [self.btnNameMutableArray addObject:@"定制艺术品图纸"];
                }else if (i == 8){
                    [self.btnNameMutableArray addObject:@"窗帘清单"];
                }else if (i == 9){
                    [self.btnNameMutableArray addObject:@""];
                }else if (i == 10){
                    [self.btnNameMutableArray addObject:@"五金清单"];
                }else if (i == 11){
                    [self.btnNameMutableArray addObject:@""];
                }else if (i == 12){
                    [self.btnNameMutableArray addObject:@"洁具清单"];
                }else if (i == 13){
                    [self.btnNameMutableArray addObject:@""];
                }else if (i == 14){
                    [self.btnNameMutableArray addObject:@"主材清单"];
                }else if (i == 15){
                    [self.btnNameMutableArray addObject:@"材料样板"];
                }
            }
            
        }else{
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
        [self.fileNameListCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:@"网络延迟请稍后再试" targetView:self.view delegateTarget:self];
    }];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud{
    self.view.userInteractionEnabled = YES;
    NSString *msg = hud.detailsLabel.text;
    if ([msg isEqualToString:@""]) {
        
    }else{
        
    }
}

@end
