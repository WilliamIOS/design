//
//  HomePageBtnsTVC.m
//  design
//
//  Created by panwei on 2020/7/7.
//

#import "HomePageBtnsTVC.h"

@implementation HomePageBtnsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

@end
