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
#import "SNAccountViewController.h"
#import "SNTabBar.h"

@interface SNMainViewController ()<SNMainNavigationControllerDelegate, SNTabBar>
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
    [self setupChildViewControll:main title:@"肃宁通" normalImage:[UIImage imageNamed:@"ktv"] selectImage:[UIImage imageNamed:@"ktv"]];
    
    SNAccountViewController *account = [[SNAccountViewController alloc] init];
    [self setupChildViewControll:account title:@"账户" normalImage:[UIImage imageNamed:@"jiudian"] selectImage:[UIImage imageNamed:@"jiudian"]];
}

#pragma mark - 添加子控制器
- (void)setupChildViewControll:(UIViewController *)vc title:(NSString *)title normalImage:(UIImage *)norImage selectImage:(UIImage *)selImage
{
    SNMainNavigationController *nav = [[SNMainNavigationController alloc] initWithRootViewController:vc];
    nav.mainDelegate = self;
    vc.title = title;
    vc.tabBarItem.image = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:nav];
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
}

#pragma mark - 添加tabBar,自定义
- (void)setupTabBar
{
    SNTabBar *customTabBar = [SNTabBar tabBar];
    customTabBar.backgroundColor=[UIColor greenColor];
    customTabBar.frame = self.tabBar.frame;
    self.customTabBar = customTabBar;
    customTabBar.delegate = self;
    [self.view addSubview:customTabBar];
    [self.tabBar removeFromSuperview];
}

#pragma mark - 按钮点击事件
- (void)tabBar:(UITabBar *)tabBar didselectedIndex:(NSInteger)index
{
    self.selectedIndex = index;
}

//#pragma mark - 发现界面隐藏tabbar的代理方法
//- (void)discoverViewControllerHiddenTabBar:(ZSDiscoverViewController *)discoverViewController
//{
//    CGRect frame = self.customTabBar.frame;
//    frame.origin.x = -320;
//    [UIView animateWithDuration:0.25 animations:^{
//        self.customTabBar.frame = frame;
//    } completion:^(BOOL finished) {
//        self.customTabBar.hidden = YES;
//    }];
//}

//#pragma mark - 我的彩票界面隐藏tabbar的代理方法
//- (void)mineViewControllerHiddenTabBar:(ZSMineViewController *)discoverViewController
//{
//    CGRect frame = self.customTabBar.frame;
//    frame.origin.x = -320;
//    [UIView animateWithDuration:0.25 animations:^{
//        self.customTabBar.frame = frame;
//    } completion:^(BOOL finished) {
//        self.customTabBar.hidden = YES;
//    }];
//}

#pragma mark - 返回按钮的代理方法实现
- (void)mainNavigationControllerShowTabBar:(SNMainNavigationController *)mainNavigationController
{
    self.customTabBar.hidden = NO;
    CGRect frame = self.customTabBar.frame;
    frame.origin.x = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.customTabBar.frame = frame;
    }];
}
@end