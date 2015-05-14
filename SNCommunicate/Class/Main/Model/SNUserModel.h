//
//  SNUserModel.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNUserModel : NSObject

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *passWord;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign, getter = isLogin) BOOL login;

+ (instancetype)sharedInstance;

+ (void)clearUserModel;

@end
