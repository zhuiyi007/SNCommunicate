//
//  SNCustomerCollect.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNCustomerCollect.h"
#import "SNCustomerCollectModel.h"

@implementation SNCustomerCollect

- (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : [SNCustomerCollectModel class]
             };
}

@end
