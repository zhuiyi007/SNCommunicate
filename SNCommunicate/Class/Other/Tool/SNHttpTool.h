//
//  SNHttpTool.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNHttpTool : NSObject

/**
 *  获取商家列表
 *
 *  @param type    商家类型
 *  @param success 成功回掉
 *  @param failure 失败回掉
 */
+ (void)getBusinessWithType:(NSString *)type
                     finish:(void (^)(id responseObject))success
                      error:(void (^)(NSError *error))failure;

/**
 *  获取注册手机验证码
 *
 *  @param PhoneNumber 手机号
 *  @param IPAddress   IP地址
 *  @param success     成功回掉
 *  @param failure     失败回掉
 */
+ (void)getSMSSendWithPhoneNumber:(NSString *)PhoneNumber
                     andIPAddress:(NSString *)IPAddress
                           finish:(void (^)(id responseObject))success
                            error:(void (^)(NSError *error))failure;

@end
