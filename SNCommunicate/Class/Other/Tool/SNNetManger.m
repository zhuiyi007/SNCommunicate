//
//  SNNetManger.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNNetManger.h"
#import "Reachability.h"

static SNNetManger *sharedInstance;

@implementation SNNetManger

+ (SNNetManger *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 使用shared方法只能做一次初始化！
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (SNNetManger *)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
    });
    return sharedInstance;
}


+(NETWORK_TYPE)networkTypeFromStatusBar {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])     {
            dataNetworkItemView = subview;
            break;
        }
    }
    NETWORK_TYPE nettype = NETWORK_TYPE_NONE;
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    nettype = [num intValue];
    return nettype;
}



- (BOOL)isNetworkRunning
{
    Reachability * reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus state = reachability.currentReachabilityStatus;
    BOOL result = NO;
    switch (state) {
        case NotReachable: {
            result = NO;
        }
            break;
        case ReachableViaWiFi: {
            result = YES;
        }
            break;
        case ReachableViaWWAN: {
            result = YES;
        }
            break;
        default: {
            result = YES;
        }
            break;
    }
    return result;
}

@end
