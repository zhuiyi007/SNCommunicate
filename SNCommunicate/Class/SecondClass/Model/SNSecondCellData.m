//
//  SNSecondCellData.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNSecondCellData.h"

@implementation SNSecondCellData

+ (SNSecondCellData *)dataWithDict:(NSDictionary *)dict
{
    SNSecondCellData *data = [[SNSecondCellData alloc] init];
    data.icon = dict[@"icon"];
    data.title = dict[@"title"];
    return data;
}

@end
