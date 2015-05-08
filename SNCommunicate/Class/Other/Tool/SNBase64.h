//
//  SNBase64.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/8.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __BASE64( text )        [CommonFunc base64StringFromText:text]
#define __TEXT( base64 )        [CommonFunc textFromBase64String:base64]

@interface SNBase64 : NSObject
/**
*  将文本转换为base64格式字符串
*
*  @param text 文本
*
*  @return base64格式字符串
*/
+ (NSString *)base64StringFromText:(NSString *)text;

/**
 *  将base64格式字符串转换为文本
 *
 *  @param base64 base64格式字符串
 *
 *  @return 文本
 */
+ (NSString *)textFromBase64String:(NSString *)base64;

@end