//
//  SNShopData.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNShopData : NSObject

@property (nonatomic, strong) NSString *Address;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *Introduction;
@property (nonatomic, strong) NSString *Level;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Point;
@property (nonatomic, strong) NSString *TEL;
@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *picURL;
@property (nonatomic, strong) NSString *registerDate;
@property (nonatomic, strong) NSString *state;

//+ (instancetype)dataWithDict:(NSDictionary *)dict;

@end
