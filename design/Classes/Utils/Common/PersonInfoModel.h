//
//  PersonInfoModel.h
//  design
//
//  Created by panwei on 2020/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonInfoModel : NSObject

@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *expire;

@end

NS_ASSUME_NONNULL_END
