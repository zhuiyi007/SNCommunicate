//
//  SNDetailsModel.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNDetailsModel.h"
#import "SNDetailsData.h"

@implementation SNDetailsModel

- (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : [SNDetailsData class]
             };
}

@end
