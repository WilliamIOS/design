//
//  ProjectScheduleTVC.m
//  design
//
//  Created by panwei on 7/9/20.
//

#import "ProjectScheduleTVC.h"
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

@interface ProjectScheduleTVC()

@property (weak, nonatomic) IBOutlet UIButton *scheduleCalendarBtn;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UIView *progressBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressViewWConstraint;

@end

@implementation ProjectScheduleTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupSettings];
    [self percentageOfProgressInterface];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellidentifier:(NSString*)cellidentifierName{
    NSString *cellidentifier = cellidentifierName;
    ProjectScheduleTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[ProjectScheduleTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setupSettings{
    [self.scheduleCalendarBtn addTarget:self action:@selector(scheduleCalendarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scheduleCalendarBtn setRoundedView:self.scheduleCalendarBtn cornerRadius:13 borderWidth:1 borderColor:PWColor(104, 124, 239)];
    [self.progressBackgroundView setRoundedView:self.progressBackgroundView cornerRadius:3 borderWidth:0.5 borderColor:[UIColor clearColor]];
    [self.progressView setRoundedView:self.progressView cornerRadius:3 borderWidth:0.5 borderColor:[UIColor clearColor]];
    self.percentageLabel.text = @"";
    self.progressViewWConstraint.constant = 0.0f;
}

- (void)scheduleCalendarBtnClick:(id)sender{
    [self.delegate didscheduleCalendarBtn];
}

#pragma mark - 文件列表
- (void)percentageOfProgressInterface{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[Configure singletonInstance].currentProjectModel.projectId forKey:@"projectId"];

    [[NetworkRequest shared] getRequest:dic serverUrl:Api_PercentageOfProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseObjectModel *responseObjectModel = [ResponseObjectModel mj_objectWithKeyValues:responseObject];
        if ([responseObjectModel.msg isEqualToString:@"success"]) {
            NSString *percentage = responseObject[@"data"];
            NSString *percentageFlag = @"%";
            self.percentageLabel.text = [NSString stringWithFormat:@"%@%@",percentage,percentageFlag];
            CGFloat progressTotalW = currentScreenW - 20*2;
            self.progressViewWConstraint.constant = progressTotalW/100 * [percentage floatValue];
            
        }else{

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

@end
