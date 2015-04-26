//
//  SNUserModel.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNUserModel.h"
static SNUserModel *sharedInstance = nil;

@implementation SNUserModel

MJCodingImplementation

+ (SNUserModel *)sharedInstance
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [[[self class] alloc] init];
        }
        return sharedInstance;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
        return sharedInstance;
    }
}

+ (id)copyWithZone:(NSZone *)zone
{
    return sharedInstance;
}

+ (void)clearUserModel
{
    sharedInstance = nil;
}

@end
