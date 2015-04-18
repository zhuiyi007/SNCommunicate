//
//  SNThirdCellData.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNThirdCellData.h"
#import "SNShopData.h"

@implementation SNThirdCellData

- (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : [SNShopData class]
             };
}

@end
