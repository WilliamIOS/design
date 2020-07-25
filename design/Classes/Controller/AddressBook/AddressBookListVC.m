//
//  AddressBookListVC.m
//  design
//
//  Created by panwei on 7/21/20.
//

#import "AddressBookListVC.h"
#import "AddressBookListHeaderTVC.h"
#import "AddressBookListContentTVC.h"
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
#import "AddressBookModel.h"

@interface AddressBookListVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectNOLabel;
@property (weak, nonatomic) IBOutlet UITableView *addressBookListTV;

@property (nonatomic,strong) NSMutableArray *firstPartyAddressBookModelMutableArray;
@property (nonatomic,strong) NSMutableArray *designAddressBookModelMutableArray;
@property (nonatomic,strong) NSMutableArray *otherAddressBookModelMutableArray;

@end

@implementation AddressBookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
    [self communicationListInterface:@"1"];
    [self communicationListInterface:@"2"];
    [self communicationListInterface:@"3"];
}

- (void)setupSettings{
    self.navigationItem.title = [Configure singletonInstance].currentProjectModel.projectName;
    self.addressBookListTV.delegate = self;
    self.addressBookListTV.dataSource = self;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = PWColor(244, 244, 244);
    self.addressBookListTV.tableFooterView = footerView;
    
    self.projectNameLabel.text = [NSString stringWithFormat:@"项目名称：%@",[Configure singletonInstance].currentProjectModel.projectName];
    self.projectNOLabel.text = [NSString stringWithFormat:@"项目编号：%@",[Configure singletonInstance].currentProjectModel.projectNumber];
}

- (NSMutableArray*)firstPartyAddressBookModelMutableArray{
    if (!_firstPartyAddressBookModelMutableArray) {
        self.firstPartyAddressBookModelMutableArray = [NSMutableArray array];
    }
    return _firstPartyAddressBookModelMutableArray;
}

- (NSMutableArray*)designAddressBookModelMutableArray{
    if (!_designAddressBookModelMutableArray) {
        self.designAddressBookModelMutableArray = [NSMutableArray array];
    }
    return _designAddressBookModelMutableArray;
}

- (NSMutableArray*)otherAddressBookModelMutableArray{
    if (!_otherAddressBookModelMutableArray) {
        self.otherAddressBookModelMutableArray = [NSMutableArray array];
    }
    return _otherAddressBookModelMutableArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
    if (section == 0) {
        num = [self.firstPartyAddressBookModelMutableArray count] + 1;
    }else if (section == 1){
        num = [self.designAddressBookModelMutableArray count] + 1;
    }else if (section == 2){
        num = [self.otherAddressBookModelMutableArray count] + 1;
    }else{
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        AddressBookListHeaderTVC *addressBookListHeaderTVC = [AddressBookListHeaderTVC cellWithTableView:tableView cellidentifier:@"AddressBookListHeaderTVC"];
        addressBookListHeaderTVC.currentIndexPath = indexPath;
        cell = addressBookListHeaderTVC;
        
    }else{
        if (indexPath.section == 0) {
            AddressBookListContentTVC *addressBookListContentTVC = [AddressBookListContentTVC cellWithTableView:tableView cellidentifier:@"AddressBookListContentTVC"];
            addressBookListContentTVC.addressBookModel = self.firstPartyAddressBookModelMutableArray[indexPath.row - 1];
            cell = addressBookListContentTVC;
            
        }else if(indexPath.section == 1){
            AddressBookListContentTVC *addressBookListContentTVC = [AddressBookListContentTVC cellWithTableView:tableView cellidentifier:@"AddressBookListContentTVC"];
            addressBookListContentTVC.addressBookModel = self.designAddressBookModelMutableArray[indexPath.row - 1];
            cell = addressBookListContentTVC;
            
        }else if(indexPath.section == 2){
            AddressBookListContentTVC *addressBookListContentTVC = [AddressBookListContentTVC cellWithTableView:tableView cellidentifier:@"AddressBookListContentTVC"];
            addressBookListContentTVC.addressBookModel = self.otherAddressBookModelMutableArray[indexPath.row - 1];
            cell = addressBookListContentTVC;
            
        }else{
            
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = 0.0f;
    if (indexPath.row == 0) {
        h = 34.0f;
    }else{
        h = 76;
    }
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat h = 0.0001f;
    if (section != 2) {
        h = 4;
    }
    return h;
}

- (void)communicationListInterface:(NSString*)contactType{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];
    [dic setObject:contactType forKey:@"contactType"];// 设计方：1 甲方：2 其他：3
    
    [[NetworkRequest shared] getRequest:dic serverUrl:Api_CommunicationList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            if ([contactType isEqualToString:@"1"]) {
                self.designAddressBookModelMutableArray = [AddressBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                NSIndexSet *reloadSet = [NSIndexSet indexSetWithIndex:1];
                [self.addressBookListTV reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationNone];
                
            }else if ([contactType isEqualToString:@"2"]){
                self.firstPartyAddressBookModelMutableArray = [AddressBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                NSIndexSet *reloadSet = [NSIndexSet indexSetWithIndex:0];
                [self.addressBookListTV reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationNone];
                
            }else if ([contactType isEqualToString:@"3"]){
                self.otherAddressBookModelMutableArray = [AddressBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                NSIndexSet *reloadSet = [NSIndexSet indexSetWithIndex:2];
                [self.addressBookListTV reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationNone];
                
            }else{
                
            }
            
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
    if ([msg isEqualToString:@""]) {
        
    }else{
        
    }
}

@end
