//
//  SNCustomerOrder.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNCustomerOrder.h"
#import "SNCustomerOrderModel.h"

@implementation SNCustomerOrder

- (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : [SNCustomerOrderModel class]
             };
}


@end
