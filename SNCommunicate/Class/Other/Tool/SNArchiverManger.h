//
//  SNArchiverManger.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNArchiverManger : NSObject

+ (SNArchiverManger *)sharedInstance;

/**
 *  归档userModel
 *
 *  @param userModel 要归档的userModel
 *
 *  @return 结果
 */
+ (BOOL)archiveWithUserModel:(SNUserModel *)userModel;
/**
 *  解档userModel
 *
 *  @return 结果
 */
+ (BOOL)unarchiveUserModel;

@end
