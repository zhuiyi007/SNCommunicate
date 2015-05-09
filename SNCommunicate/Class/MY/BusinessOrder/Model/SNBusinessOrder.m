//
//  SNBusinessOrder.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/9.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNBusinessOrder.h"
#import "SNBusinessOrderModel.h"

@implementation SNBusinessOrder

- (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : [SNBusinessOrderModel class]
             };
}

@end
