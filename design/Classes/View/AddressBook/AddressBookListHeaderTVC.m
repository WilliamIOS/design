//
//  AddressBookListHeaderTVC.m
//  design
//
//  Created by panwei on 7/23/20.
//

#import "AddressBookListHeaderTVC.h"

@interface AddressBookListHeaderTVC()

@property (weak, nonatomic) IBOutlet UILabel *headerNameLabel;


@end

@implementation AddressBookListHeaderTVC

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
    AddressBookListHeaderTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[AddressBookListHeaderTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath{
    _currentIndexPath = currentIndexPath;
    if (currentIndexPath.section == 0) {
        self.headerNameLabel.text = @"甲方";
    }else if (currentIndexPath.section == 1){
        self.headerNameLabel.text = @"设计方";
    }else if (currentIndexPath.section == 2){
        self.headerNameLabel.text = @"其他";
    }else{
        
    }
}

@end
