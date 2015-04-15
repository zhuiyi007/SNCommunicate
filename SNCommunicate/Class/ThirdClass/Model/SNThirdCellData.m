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

+ (SNThirdCellData *)dataWithDict:(NSDictionary *)dict
{
    SNThirdCellData *data = [[SNThirdCellData alloc] init];
    data.status = dict[@"status"];
    data.result = dict[@"result"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *tempdict in data.result) {
        SNShopData *temp = [SNShopData dataWithDict:tempdict];
        [tempArray addObject:temp];
    }
    data.result = tempArray;
    return data;
}

@end
