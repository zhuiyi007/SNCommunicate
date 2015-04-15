//
//  SNHttpTool.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNHttpTool : NSObject

+ (void)getBusinessWithType:(NSString *)type
                     finish:(void (^)(id responseObject))success
                      error:(void (^)(NSError *error))failure;

@end
