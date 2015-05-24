//
//  Define.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#ifndef SNCommunicate_Define_h
#define SNCommunicate_Define_h

#pragma 常用属性值

#define SNScreenBounds [UIScreen mainScreen].bounds.size
#define SNKeyWindow    [UIApplication sharedApplication].keyWindow
#define SNColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define SNCGColor(r, g, b) CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ (r) / 255.0, (g) / 255.0, (b) / 255.0, 1 })

#define SNMainBackgroundColor SNColor(254, 242, 229)
#define SNPriceColor          SNColor(255, 101, 80)
#define SNMainGreenColor      SNColor(77, 103, 116)


#pragma NSLog

#ifdef DEBUG
#define SNLog(...) NSLog(__VA_ARGS__)
#else
#define SNLog(...)
#endif

#pragma 常用frame

#define SNTableViewFrame CGRectMake(0, 0, SNScreenBounds.width, SNScreenBounds.height - 64)

#pragma 路径
// 用户信息路径
#define SNUserInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"userModel"]

#define SNUserDefaults [NSUserDefaults standardUserDefaults]

#pragma 通知
#define SNClickMyTabBar     @"SNClickMyTabBar"      // 点击个人中心的通知
#define SNLoginSuccess      @"SNLoginSuccess"       // 登录成功
#define SNPointSuccess      @"SNPointSuccess"       // 点赞成功


#endif

// 订单状态枚举
typedef NS_ENUM(NSInteger, SNOrderStatus) {
    SNOrderStatusUnfinished,
    SNOrderStatusAccept,
    SNOrderStatusFinished
};
