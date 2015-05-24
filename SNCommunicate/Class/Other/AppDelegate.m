//
//  AppDelegate.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "AppDelegate.h"
#import "SNMainViewController.h"
#import "SNGuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [NSThread sleepForTimeInterval:5.0];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self chooseRootViewController];
    return YES;
}

- (void)chooseRootViewController
{
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *curVersion = dict[versionKey];
    NSString *lastVersion = [SNArchiverManger objectForKey:@"version"];
    
    if ([curVersion isEqualToString:lastVersion]) { // 没有新版本
        SNMainViewController *mainViewController = [[SNMainViewController alloc] init];
        [self.window setRootViewController:mainViewController];
        
    }else{ // 有新版本
        [SNArchiverManger setObject:curVersion forKey:@"version"];
        // 进入引导界面
        SNGuideViewController *guideVc = [[SNGuideViewController alloc] init];
        [self.window setRootViewController:guideVc];
    }
    self.window.backgroundColor = SNMainBackgroundColor;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
