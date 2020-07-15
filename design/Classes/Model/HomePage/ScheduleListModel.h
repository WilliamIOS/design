//
//  ScheduleListModel.h
//  design
//
//  Created by panwei on 7/15/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleListModel : NSObject

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *delFlag;
@property (nonatomic,strong) NSString *deleteDate;
@property (nonatomic,strong) NSString *deleter;
@property (nonatomic,strong) NSString *scheduleId;
@property (nonatomic,strong) NSString *note;
@property (nonatomic,strong) NSString *planningTime;
@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) NSString *realTime;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic,strong) NSString *stage;
@property (nonatomic,strong) NSString *tenantCode;
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updater;
@property (nonatomic,strong) NSString *workContent;



@end

NS_ASSUME_NONNULL_END
