//
//  ViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMainViewController.h"
#import "SNMainNavigationController.h"
#import "SNCommunicateMainViewController.h"
#import "SNMYViewController.h"
#import "SNTabBar.h"

@interface SNMainViewController ()<SNTabBar>
@property (nonatomic, weak) SNTabBar *customTabBar;

@end

@implementation SNMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1. 添加tabBar
    [self setupTabBar];
    // 2. 添加子控件
    [self addChildSubViews];
    
}

#pragma mark - 添加子控件
- (void)addChildSubViews
{
    SNCommunicateMainViewController *main = [[SNCommunicateMainViewController alloc] init];
    [self setupChildViewControll:main title:@"肃宁通" tabBarTitle:@"首页" normalImage:nil selectImage:nil];

    SNMYViewController *my = [[SNMYViewController alloc] init];
    [self setupChildViewControll:my title:@"中心" tabBarTitle:@"中心" normalImage:nil selectImage:nil];
}

#pragma mark - 添加子控制器
- (void)setupChildViewControll:(UIViewController *)vc title:(NSString *)title tabBarTitle:(NSString *)tabBarTitle normalImage:(UIImage *)norImage selectImage:(UIImage *)selImage
{
    SNMainNavigationController *nav = [[SNMainNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarController.tabBar.translucent = NO;
    vc.title = title;
    vc.tabBarItem.title = tabBarTitle;
    vc.tabBarItem.image = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:nav];
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
}

#pragma mark - 添加tabBar,自定义
- (void)setupTabBar
{
    SNTabBar *customTabBar = [SNTabBar tabBar];
    customTabBar.frame = self.tabBar.frame;
    self.customTabBar = customTabBar;
    customTabBar.myDelegate = self;
    [self.view addSubview:customTabBar];
    [self.tabBar removeFromSuperview];
}

#pragma mark - 按钮点击事件
- (void)tabBar:(UITabBar *)tabBar didselectedIndex:(NSInteger)index
{
    self.selectedIndex = index;
    if (index == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SNClickMyTabBar object:self];
    }
}

@end