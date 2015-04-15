//
//  SNShopData.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNShopData.h"

@implementation SNShopData

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)dataWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
