//
//  Configure.m
//  design
//
//  Created by panwei on 7/9/20.
//

#import "Configure.h"

static Configure *singletonInstance = nil;

@implementation Configure

+ (instancetype)singletonInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        singletonInstance = [[self alloc] init];
    });
    return singletonInstance;
}

@end
