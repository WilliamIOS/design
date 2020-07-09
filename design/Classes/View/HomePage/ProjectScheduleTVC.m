//
//  ProjectScheduleTVC.m
//  design
//
//  Created by panwei on 7/9/20.
//

#import "ProjectScheduleTVC.h"
#import "UIView+Extension.h"
#import "Macro.h"

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
}

- (void)scheduleCalendarBtnClick:(id)sender{
    
}

@end
