//
//  SNUserModel.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNUserModel.h"
static SNUserModel *sharedInstance;

@implementation SNUserModel

MJCodingImplementation

+ (SNUserModel *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 使用shared方法只能做一次初始化！
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (SNUserModel *)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
    });
    return sharedInstance;
}


+ (void)clearUserModel
{
    sharedInstance.phoneNumber = nil;
    sharedInstance.passWord = nil;
    sharedInstance.name = nil;
    sharedInstance.login = NO;
}

@end
