//
//  ScheduleInsertVC.m
//  design
//
//  Created by panwei on 7/21/20.
//

#import "ScheduleInsertVC.h"
#import "UIView+Extension.h"
#import "Macro.h"
#import "ConceptSchemeHistoryListVC.h"
#import "MJRefresh.h"
#import "MBProgressHUD+PW.h"
#import "NetworkRequest.h"
#import "MJExtension.h"
#import "ServerApi.h"
#import "ResponseObjectModel.h"
#import "PersonInfoModel.h"
#import "Configure.h"
#import "ScheduleInsertHeaderTVC.h"
#import "ScheduleInsertPicTVC.h"
#import "UploadMediaModel.h"
#import "ScheduleInsertModel.h"

@interface ScheduleInsertVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *insertTV;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong) NSMutableArray *picMutableArray;
@property (nonatomic,strong) ScheduleInsertModel *scheduleInsertModel;

@end

@implementation ScheduleInsertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.insertTV.dataSource = self;
    self.insertTV.delegate = self;
    self.insertTV.estimatedRowHeight = 300.0f;//估算高度
    self.insertTV.rowHeight = UITableViewAutomaticDimension;
    [self.submitBtn setBackgroundColor:PWColor(219, 220, 221)];
    [self.submitBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.submitBtn.userInteractionEnabled = false;
    [self.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scheduleInsertVCRefreshNotificationClick:) name:@"ScheduleInsertVCRefreshNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestInsertPicClick:) name:@"RequestInsertPic" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scheduleInsertModelUpdateClick:) name:@"ScheduleInsertModelUpdateNotification" object:nil];

    UploadMediaModel *uploadMediaModel = [[UploadMediaModel alloc] init];
    uploadMediaModel.mediaType = @"2";
    [self.picMutableArray addObject:uploadMediaModel];
    self.scheduleInsertModel = [[ScheduleInsertModel alloc] init];
    self.scheduleInsertModel.scheduleName = @"";
    self.scheduleInsertModel.changeDetails = @"";
    [self.insertTV reloadData];
}

- (NSMutableArray*)picMutableArray{
    if (!_picMutableArray) {
        self.picMutableArray = [NSMutableArray array];
    }
    return _picMutableArray;
}

- (void)scheduleInsertVCRefreshNotificationClick:(NSNotification *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.insertTV reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:1]] withRowAnimation:UITableViewRowAnimationNone];

    });
}

- (void)scheduleInsertModelUpdateClick:(NSNotification *)text{
    if ([self.scheduleInsertModel.scheduleName isEqualToString:@""] && [self.scheduleInsertModel.changeDetails isEqualToString:@""] && [self.picMutableArray count] == 1) {
        [self.submitBtn setBackgroundColor:PWColor(219, 220, 221)];
        [self.submitBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = false;
    }else{
        [self.submitBtn setBackgroundColor:[UIColor redColor]];
        [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = true;
    }
}

- (void)requestInsertPicClick:(NSNotification *)text{
    [self photoAlertController];
}

- (void)submitBtnClick:(id)sender{
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    [self scheduleInsertInterface];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        ScheduleInsertHeaderTVC *scheduleInsertHeaderTVC = [ScheduleInsertHeaderTVC cellWithTableView:tableView cellidentifier:@"ScheduleInsertHeaderTVC"];
        scheduleInsertHeaderTVC.scheduleInsertModel = self.scheduleInsertModel;
        cell = scheduleInsertHeaderTVC;
    }else if (indexPath.row == 1){
        ScheduleInsertPicTVC *scheduleInsertPicTVC = [ScheduleInsertPicTVC cellWithTableView:tableView cellidentifier:@"ScheduleInsertPicTVCWithScheduleInsert"];
        scheduleInsertPicTVC.picMutableArray = self.picMutableArray;
        cell = scheduleInsertPicTVC;
    }else{
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}

#pragma mark - 打开上传相册界面
-(void)photoAlertController{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.videoQuality = UIImagePickerControllerQualityType640x480;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }];
    
    UIAlertAction *choicePhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //点击了从手机相册选择
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        pickerImage.delegate = self;
        [self presentViewController:pickerImage animated:YES completion:^{
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:photographAction];
    [alertController addAction:choicePhotoAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [MBProgressHUD showOnlyChrysanthemumWithView:self.view delegateTarget:self];
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        [picker dismissViewControllerAnimated:YES completion:^{
            UploadMediaModel *uploadMediaModel = [[UploadMediaModel alloc] init];
            uploadMediaModel.mediaType = @"0";
            uploadMediaModel.picImageData = imageData;
            [self uploadImageInterface:uploadMediaModel];
        }];
        
    }else if ([mediaType isEqualToString:@"public.movie"]){
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"video path: %@", info[UIImagePickerControllerMediaURL]);
            UploadMediaModel *uploadMediaModel = [[UploadMediaModel alloc] init];
            uploadMediaModel.mediaType = @"1";
            uploadMediaModel.videoUrl = info[UIImagePickerControllerMediaURL];
            [self uploadImageInterface:uploadMediaModel];
        }];
    }else{
        [MBProgressHUD hideHUDForView:self.view];
    }
}

#pragma mark - 上传图片或视频
- (void)uploadImageInterface:(UploadMediaModel*)uploadMediaModel{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *token = [Configure singletonInstance].personInfoModel.token;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg", @"image/png", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];

    NSString *url = [NSString stringWithFormat:@"%@%@",Base_URL_Project,Api_UploadImgFile];
    
    NSData *imageData;
    if ([uploadMediaModel.mediaType isEqualToString:@"0"]) {
        imageData = uploadMediaModel.picImageData;
    }else if ([uploadMediaModel.mediaType isEqualToString:@"1"]){
        imageData = [NSData dataWithContentsOfURL:uploadMediaModel.videoUrl];
    }else{
        
    }

    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([uploadMediaModel.mediaType isEqualToString:@"0"]) {
          [formData appendPartWithFileData:imageData name:@"file" fileName:@"files.png" mimeType:@"image/png"];
        }else if ([uploadMediaModel.mediaType isEqualToString:@"1"]){
           [formData appendPartWithFileData:imageData name:@"file" fileName:@"files.mov" mimeType:@"application/octet-stream"];
        }else{
            
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        uploadMediaModel.sucData = responseObject[@"data"];
        if ([uploadMediaModel.mediaType isEqualToString:@"0"]) {
        }else if ([uploadMediaModel.mediaType isEqualToString:@"1"]){
//           uploadMediaModel.videoImage = [uploadMediaModel getVideoImageWithTime:1.0 videoPath:uploadMediaModel.videoUrl];
        }else{
            
        }
        [self.picMutableArray insertObject:uploadMediaModel atIndex:[self.picMutableArray count] - 1];
        
        if ([self.scheduleInsertModel.scheduleName isEqualToString:@""] && [self.scheduleInsertModel.changeDetails isEqualToString:@""] && [self.picMutableArray count] == 1) {
            [self.submitBtn setBackgroundColor:PWColor(219, 220, 221)];
            [self.submitBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            self.submitBtn.userInteractionEnabled = false;
        }else{
            [self.submitBtn setBackgroundColor:[UIColor redColor]];
            [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.submitBtn.userInteractionEnabled = true;
        }
        
        [self.insertTV reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];

    }];
}

#pragma mark - 新增变更日程
- (void)scheduleInsertInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    [dic setObject:self.scheduleInsertModel.scheduleName forKey:@"scheduleName"];
    [dic setObject:self.scheduleInsertModel.changeDetails forKey:@"changeDetails"];
    
    NSString *file = @"";
    if ([self.picMutableArray count] > 1) {
        for (int a = 0; a < [self.picMutableArray count]; a++) {
            UploadMediaModel *uploadMediaModel = self.picMutableArray[a];
            if (![uploadMediaModel.mediaType isEqualToString:@"2"]) {
                if ([file isEqualToString:@""]) {
                    file = uploadMediaModel.sucData;
                }else{
                    file = [NSString stringWithFormat:@"%@,%@",file,uploadMediaModel.sucData];
                }
            }
        }
    }
    [dic setObject:file forKey:@"documentUrl"];
    
    [[NetworkRequest shared] postRequest:dic serverUrl:Api_ScheduleInsert success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            [MBProgressHUD showMessage:@"提交成功" targetView:self.view delegateTarget:self];
            
        }else{
            [MBProgressHUD showMessage:responseObjectModel.msg targetView:self.view delegateTarget:self];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:@"网络延迟请稍后再试" targetView:self.view delegateTarget:self];
    }];
}


#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud{
    self.view.userInteractionEnabled = YES;
    NSString *msg = hud.detailsLabel.text;
    if ([msg isEqualToString:@"提交成功"]) {
        for (int a = 0; a < [self.picMutableArray count]; a++) {
            UploadMediaModel *uploadMediaModel = self.picMutableArray[a];
            if ([uploadMediaModel.mediaType isEqualToString:@"1"]) {
                NSFileManager *defauleManager = [NSFileManager defaultManager];
                [defauleManager removeItemAtURL:uploadMediaModel.videoUrl error:nil];
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
    }
}

@end
