//
//  AddressBookListContentTVC.m
//  design
//
//  Created by panwei on 7/23/20.
//

#import "AddressBookListContentTVC.h"

@interface AddressBookListContentTVC()

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dutyLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkmanLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation AddressBookListContentTVC

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
    AddressBookListContentTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[AddressBookListContentTVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    return cell;
}

- (void)setAddressBookModel:(AddressBookModel *)addressBookModel{
    _addressBookModel = addressBookModel;
    self.companyNameLabel.text = addressBookModel.unit;
    self.dutyLabel.text = addressBookModel.position;
    self.linkmanLabel.text = addressBookModel.contact;
    self.phoneLabel.text = addressBookModel.phone;
    self.emailLabel.text = addressBookModel.mail;
}

@end
