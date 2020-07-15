//
//  HomePageListVC.m
//  design
//
//  Created by panwei on 2020/7/6.
//

#import "HomePageListVC.h"
#import "HomePageBtnsTVC.h"
#import "ProjectScheduleTVC.h"
#import "ConceptSchemeListVC.h"
#import "SoftLoadingListVC.h"
#import "ProjectScheduleVC.h"
#import "Configure.h"
#import "PlaneFigureListVC.h"
#import "DesignSketchListVC.h"
#import "ConstructionPlansListVC.h"
#import "OtherFileListVC.h"
#import "NetworkRequest.h"
#import "MBProgressHUD+PW.h"
#import "ResponseObjectModel.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "PersonInfoModel.h"

@interface HomePageListVC ()<UITableViewDelegate,UITableViewDataSource,HomePageBtnsTVCDelegate,ProjectScheduleTVCDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homePageTV;

@end

@implementation HomePageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.homePageTV.dataSource = self;
    self.homePageTV.delegate = self;
    self.homePageTV.estimatedRowHeight = 300.0f;//估算高度
    self.homePageTV.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
       HomePageBtnsTVC *homePageBtnsTVC = [HomePageBtnsTVC cellWithTableView:tableView cellidentifier:@"HomePageBtnsTVC"];
        homePageBtnsTVC.delegate = self;
        cell = homePageBtnsTVC;

    }else if (indexPath.section == 1){
        ProjectScheduleTVC *projectScheduleTVC = [ProjectScheduleTVC cellWithTableView:tableView cellidentifier:@"ProjectScheduleTVC"];
        projectScheduleTVC.delegate = self;
        cell = projectScheduleTVC;
        
    }else{

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat h = 0.0001;
    if (section == 0 ) {
        h = 10.0f;
    }
    return h;
}

#pragma mark - HomePageBtnsTVCDelegate
- (void)didConceptSchemeBtn{
    ConceptSchemeListVC *conceptSchemeListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConceptSchemeListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:conceptSchemeListVC animated:true];
}

- (void)didDesignSketchBtn{
    DesignSketchListVC *designSketchListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DesignSketchListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:designSketchListVC animated:true];
}

- (void)didPlaneFigureBtn{
    PlaneFigureListVC *planeFigureListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaneFigureListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:planeFigureListVC animated:true];
}

- (void)didConstructionPlansBtn{
    ConstructionPlansListVC *constructionPlansListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConstructionPlansListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:constructionPlansListVC animated:true];
}

- (void)didSoftLoadingBtn{
    SoftLoadingListVC *softLoadingListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SoftLoadingListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:softLoadingListVC animated:true];
}

- (void)didOtherFileBtn{
    OtherFileListVC *otherFileListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OtherFileListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:otherFileListVC animated:true];
}

- (void)didAllLoadingBtn{
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self oneClickToDownloadInterface];
}

#pragma mark - ProjectScheduleTVCDelegate
- (void)didscheduleCalendarBtn{
   ProjectScheduleVC *projectScheduleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectScheduleVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:projectScheduleVC animated:true];
}

#pragma mark - 一键下载
- (void)oneClickToDownloadInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    
    [[NetworkRequest shared] getRequest:dic serverUrl:Api_DownLoadAll success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            NSString *urlStr = responseObject[@"data"];
            [self fileLoading:urlStr];
            
        }else{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:@"网络延迟请稍后再试" targetView:self.view delegateTarget:self];
    }];
}

- (void)fileLoading:(NSString *)url{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString * urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documentPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        
    }];
    // 4. 开启下载任务
    [downloadTask resume];
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
