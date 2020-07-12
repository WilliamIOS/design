//
//  SoftLoadingListVC.m
//  design
//
//  Created by panwei on 7/10/20.
//

#import "SoftLoadingListVC.h"
#import "SoftLoadingNameCVC.h"
#import "Macro.h"

@interface SoftLoadingListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *fileNameListCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *allSoftLoadingFileBtn;

@end

@implementation SoftLoadingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title =@"我的项目";
    self.fileNameListCollectionView.delegate = self;
    self.fileNameListCollectionView.dataSource = self;
    [self.allSoftLoadingFileBtn addTarget:self action:@selector(allSoftLoadingFileBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)allSoftLoadingFileBtnClick:(id)sender{
    
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(currentScreenW*0.5, 60);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SoftLoadingNameCVC *softLoadingNameCVC = [collectionView dequeueReusableCellWithReuseIdentifier:@"SoftLoadingNameCVC" forIndexPath:indexPath];
    softLoadingNameCVC.currentIndexPath = indexPath;
    return softLoadingNameCVC;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}
@end
