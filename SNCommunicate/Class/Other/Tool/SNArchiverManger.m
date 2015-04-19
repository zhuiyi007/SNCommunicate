//
//  SNArchiverManger.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNArchiverManger.h"

static SNArchiverManger *sharedInstance = nil;

@implementation SNArchiverManger

+ (SNArchiverManger *)sharedInstance
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [[[self class] alloc] init];
        }
        return sharedInstance;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
        return sharedInstance;
    }
}

+ (id)copyWithZone:(NSZone *)zone
{
    return sharedInstance;
}


+ (BOOL)archiveWithUserModel:(SNUserModel *)userModel
{
    return [NSKeyedArchiver archiveRootObject:userModel toFile:SNUserInfoPath];
}

+ (BOOL)unarchiveUserModel
{
    SNUserModel *model = [SNUserModel sharedInstance];
    model = [NSKeyedUnarchiver unarchiveObjectWithFile:SNUserInfoPath];
    return model;
}

/*解归档
 NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"array.src"];
 id array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
 NSLog(@"%@",array);
 */



@end
