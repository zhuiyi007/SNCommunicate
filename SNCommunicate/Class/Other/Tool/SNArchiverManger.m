//
//  SNArchiverManger.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNArchiverManger.h"

static SNArchiverManger *sharedInstance;

@implementation SNArchiverManger

+ (SNArchiverManger *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 使用shared方法只能做一次初始化！
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (SNArchiverManger *)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
    });
    return sharedInstance;
}


+ (BOOL)archiveWithUserModel:(SNUserModel *)userModel
{
    return [NSKeyedArchiver archiveRootObject:userModel toFile:SNUserInfoPath];
}

+ (BOOL)unarchiveUserModel
{
    SNUserModel *model = [SNUserModel sharedInstance];
    model = [NSKeyedUnarchiver unarchiveObjectWithFile:SNUserInfoPath];
    return model;
}


@end
