//
//  ScheduleInsertHeaderTVC.m
//  design
//
//  Created by panwei on 7/24/20.
//

#import "ScheduleInsertHeaderTVC.h"
#import "UITextView+YLTextView.h"

@interface ScheduleInsertHeaderTVC()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *scheduleNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *scheduleDetailTextView;


@end

@implementation ScheduleInsertHeaderTVC

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
    ScheduleInsertHeaderTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[ScheduleInsertHeaderTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setupSettings{
    self.scheduleDetailTextView.delegate = self;
    [self.scheduleDetailTextView setPlaceholdFont:[UIFont systemFontOfSize:14]];
    self.scheduleDetailTextView.placeholder = @"变更详情";
    [self.scheduleNameTextField addTarget:self action:@selector(changedScheduleNameTextField:) forControlEvents:UIControlEventEditingChanged];
}

- (void)changedScheduleNameTextField:(id)sender{
    UITextField *textField = (UITextField*)sender;
    self.scheduleInsertModel.scheduleName = textField.text;
    NSNotification *notification =[NSNotification notificationWithName:@"ScheduleInsertModelUpdateNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)textViewDidChange:(UITextView *)textView{
    self.scheduleInsertModel.changeDetails = textView.text;
    self.scheduleDetailTextView.placeholder = @"变更详情";
    NSNotification *notification =[NSNotification notificationWithName:@"ScheduleInsertModelUpdateNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
@end
