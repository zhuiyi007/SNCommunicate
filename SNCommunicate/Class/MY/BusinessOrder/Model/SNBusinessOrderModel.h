//
//  SNBusinessOrderModel.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/9.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNBusinessOrderModel : NSObject

@property (nonatomic, strong) NSString *Count;
@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *customerTEL;
@property (nonatomic, strong) NSString *orderDate;
@property (nonatomic, strong) NSString *orderNum;
@property (nonatomic, strong) NSString *orderState;
@property (nonatomic, strong) NSString *serviceID;
@property (nonatomic, strong) NSString *shangID;
@property (nonatomic, strong) NSString *totalPrice;

@end
