//
//  Configure.h
//  design
//
//  Created by panwei on 7/9/20.
//

#import <Foundation/Foundation.h>
#import "PersonInfoModel.h"
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Configure : NSObject

@property (nonatomic,strong,nullable) PersonInfoModel *personInfoModel;
@property (nonatomic,strong,nullable) ProjectModel *currentProjectModel;
@property (nonatomic,strong,nullable) NSMutableArray *remindDataMutableArray;


+ (instancetype)singletonInstance;

@end

NS_ASSUME_NONNULL_END
