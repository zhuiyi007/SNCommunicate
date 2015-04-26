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
    // 3.判断是否登录
    [self login];
    
}

#pragma mark - 添加子控件
- (void)addChildSubViews
{
    SNCommunicateMainViewController *main = [[SNCommunicateMainViewController alloc] init];
    [self setupChildViewControll:main title:@"肃宁通" normalImage:[UIImage imageNamed:@"ktv"] selectImage:[UIImage imageNamed:@"ktv"]];

    SNMYViewController *my = [[SNMYViewController alloc] init];
    [self setupChildViewControll:my title:@"中心" normalImage:[UIImage imageNamed:@"jiudian"] selectImage:[UIImage imageNamed:@"jiudian"]];
}

#pragma mark - 添加子控制器
- (void)setupChildViewControll:(UIViewController *)vc title:(NSString *)title normalImage:(UIImage *)norImage selectImage:(UIImage *)selImage
{
    SNMainNavigationController *nav = [[SNMainNavigationController alloc] initWithRootViewController:vc];
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

- (void)login
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:SNUserInfoPath]) {
        // 本地没有缓存信息
        return;
    }
    else { // 本地有缓存信息,直接给服务器验证
        [SNArchiverManger unarchiveUserModel];
        SNUserModel *userModel = [SNUserModel sharedInstance];
        [SNHttpTool customerLoginWithPhoneNumber:userModel.phoneNumber
                                        passWord:userModel.passWord
                                          finish:^(id responseObject) {
                                              [MBProgressHUD hideHUD];
                                              SNLog(@"%@", responseObject);
                                              if ([responseObject[@"status"] integerValue] == 0) {
                                                  // 验证不通过,删除本地缓存
                                                  [[NSFileManager defaultManager] removeItemAtPath:SNUserInfoPath error:nil];
                                                  return;
                                              }
                                              userModel.login = YES;
                                          }
                                           error:^(NSError *error) {
                                               SNLog(@"%@", error);
                                           }];
    }
    
}
@end