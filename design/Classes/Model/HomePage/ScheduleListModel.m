//
//  ScheduleListModel.m
//  design
//
//  Created by panwei on 7/15/20.
//

#import "ScheduleListModel.h"

@implementation ScheduleListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"scheduleId":@"id"};
}

@end
