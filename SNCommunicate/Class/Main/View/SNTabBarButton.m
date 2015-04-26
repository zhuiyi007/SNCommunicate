//
//  SNTabBarButton.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNTabBarButton.h"

@implementation SNTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:SNMainGreenColor];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:2.0]; //边框宽度
        [self.layer setBorderColor:SNCGColor(119, 119, 119)]; //边框颜色
        [self setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{}


@end
