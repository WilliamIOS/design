//
//  AddressBookModel.h
//  design
//
//  Created by panwei on 7/23/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookModel : NSObject

@property (nonatomic,strong) NSString *contact;
@property (nonatomic,strong) NSString *contactType;
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *delFlag;
@property (nonatomic,strong) NSString *deleteDate;
@property (nonatomic,strong) NSString *deleter;
@property (nonatomic,strong) NSString *fax;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *mail;
@property (nonatomic,strong) NSString *note;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) NSString *tenantCode;
@property (nonatomic,strong) NSString *unit;
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updater;


@end

NS_ASSUME_NONNULL_END
