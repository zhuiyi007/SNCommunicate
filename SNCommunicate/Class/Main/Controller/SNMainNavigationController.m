//
//  SNMainNavigationController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMainNavigationController.h"

@interface SNMainNavigationController ()<UINavigationControllerDelegate>

@end

@implementation SNMainNavigationController

#pragma mark - 第一次使用这个类或者子类时调用,且只会调用一次
+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[SNMainNavigationController class], nil];
    [bar setBarTintColor:SNColor(49, 78, 92)];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = SNColor(255, 235, 213);
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [bar setTitleTextAttributes:dict];
}

#pragma mark - 重写push方法,实现返回按钮的重写
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 当需要返回时才显示返回按钮
//    if (self.childViewControllers.count) {
//        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginalNamed:@"NavBack"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
//        viewController.navigationItem.leftBarButtonItem = back;
//    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 返回按钮的点击事件
- (void)back
{
    if ([self.mainDelegate respondsToSelector:@selector(mainNavigationControllerShowTabBar:)] && !self.childViewControllers.count) {
        [self.mainDelegate mainNavigationControllerShowTabBar:self];
    }
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 实现滑动返回
    self.interactivePopGestureRecognizer.delegate = nil;
    
    self.delegate = self;
}

#pragma mark - 重写pop方法,实现滑动返回和按钮返回的功能
-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

@end
