//
//  SNMainTableView.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMainTableView.h"

@implementation SNMainTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = SNMainBackgroundColor;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SNMainBackgroundColor;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = SNMainBackgroundColor;
    }
    return self;
}

- (UIEdgeInsets)contentInset
{
    return UIEdgeInsetsMake(0, 0, -49, 0);
}


@end
