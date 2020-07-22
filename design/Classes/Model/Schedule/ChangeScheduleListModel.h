//
//  ScheduleListModel.h
//  design
//
//  Created by panwei on 7/22/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeScheduleListModel : NSObject

@property (nonatomic,strong) NSString *changeDetails;
@property (nonatomic,strong) NSString *changeName;
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *delFlag;
@property (nonatomic,strong) NSString *deleteDate;
@property (nonatomic,strong) NSString *deleter;
@property (nonatomic,strong) NSString *documentName;
@property (nonatomic,strong) NSString *documentUrl;
@property (nonatomic,strong) NSString *scheduleId;
@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) NSString *scheduleName;
@property (nonatomic,strong) NSString *tenantCode;
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updater;


@end

NS_ASSUME_NONNULL_END
