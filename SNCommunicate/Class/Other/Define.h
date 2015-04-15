//
//  Define.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#ifndef SNCommunicate_Define_h
#define SNCommunicate_Define_h

// 常用属性值
#define SNScreenBounds [UIScreen mainScreen].bounds.size
#define SNKeyWindow    [UIApplication sharedApplication].keyWindow
#define SNColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define SNMainBackgroundColor SNColor(254, 242, 229)
// NSLog
#ifdef DEBUG
#define SNLog(...) NSLog(__VA_ARGS__)
#else
#define SNLog(...)
#endif

// PList文件名


#endif
