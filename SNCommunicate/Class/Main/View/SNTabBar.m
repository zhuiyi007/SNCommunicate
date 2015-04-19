//
//  SNTabBar.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNTabBar.h"
#import "SNTabBarButton.h"
@interface SNTabBar()

@property (nonatomic, weak) UIButton *btn;

@end

@implementation SNTabBar


- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    NSInteger index = self.subviews.count;
    SNTabBarButton *btn = [SNTabBarButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:item.image forState:UIControlStateNormal];
    [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
    btn.tag = index;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    if (index == 0) {
        self.btn = btn;
        [self btnClick:btn];
    }
    [self addSubview:btn];
}

- (void)btnClick:(SNTabBarButton *)btn
{
    self.btn.selected = NO;
    btn.selected = YES;
    self.btn = btn;
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didselectedIndex:)]) {
        [self.myDelegate tabBar:self didselectedIndex:btn.tag];
    }
}

+(instancetype)tabBar
{
    SNTabBar *tabBar = [[SNTabBar alloc] init];
    return tabBar;
}

- (void)layoutSubviews
{
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        int width = self.frame.size.width / count;
        int x = i * width;
        int height = self.frame.size.height;
        [btn setFrame:CGRectMake(x, 0, width, height)];
    }
}
@end

