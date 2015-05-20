//
//  SNCustomerOrderModel.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNCustomerOrderModel : NSObject

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *TEL;
@property (nonatomic, strong) NSString *customerTEL;
@property (nonatomic, strong) NSString *orderNum;
@property (nonatomic, strong) NSString *orderState;
@property (nonatomic, strong) NSString *totalPrice;

@end
