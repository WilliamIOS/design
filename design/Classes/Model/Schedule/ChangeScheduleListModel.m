//
//  ScheduleListModel.m
//  design
//
//  Created by panwei on 7/22/20.
//

#import "ChangeScheduleListModel.h"

@implementation ChangeScheduleListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"scheduleId":@"id"};
}

@end
