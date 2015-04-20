//
//  SNTabBar.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNTabBar;

@protocol SNTabBar <NSObject>
- (void)tabBar:(SNTabBar *)tabBar didselectedIndex:(NSInteger)index;
@end

@interface SNTabBar : UITabBar

+ (instancetype)tabBar;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

- (void)hiddenTabBar;

- (void)showTabBar;

@property (nonatomic, weak) id<SNTabBar> myDelegate;

@end
