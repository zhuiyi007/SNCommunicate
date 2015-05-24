//
//  SNGuideTool.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/24.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNGuideTool.h"

@implementation SNGuideTool
+ (void)chooseRootViewController:(UIWindow *)window
{
    
    // 判断是否有新的版本
    // 获取当前用户手机的版本
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    // CoreFundation - >  Fundation 用桥接__bridge
    NSString *curVersion = dict[versionKey];

    // 获取之前存储版本
    NSString *lastVersion = [ILSaveTool objectForKey:ILVersionKey];

    if ([curVersion isEqualToString:lastVersion]) { // 没有新版本
        // 设置跟控制器为main
        ILTabBarController *tabBar = [[ILTabBarController alloc] init];

        window.rootViewController = tabBar;

    }else{ // 有新版本

        // 存储最新版本
        [ILSaveTool setObject:curVersion forKey:ILVersionKey];

        // 进入引导界面
        ILGuideViewController *guideVc = [[ILGuideViewController alloc] init];

        window.rootViewController = guideVc;

    }
    
}
@end
