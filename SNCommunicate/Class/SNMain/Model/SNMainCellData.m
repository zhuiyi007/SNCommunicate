//
//  SNMainCellData.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMainCellData.h"

@implementation SNMainCellData

+ (SNMainCellData *)dataWithDict:(NSDictionary *)dict
{
    SNMainCellData *data = [[SNMainCellData alloc] init];
    data.icon = dict[@"icon"];
    data.title = dict[@"title"];
    return data;
}

@end
