//
//  SNThirdCellData.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNThirdCellData : NSObject

@property (nonatomic, strong) NSArray *result;
@property (nonatomic, strong) NSString *status;


+ (SNThirdCellData *)dataWithDict:(NSDictionary *)dict;

@end
