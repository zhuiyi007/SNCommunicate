//
//  SNOtherGoodsView.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNOtherGoodsView.h"
#import "SNDetailsData.h"
#import "SNOtherGoodsLabelView.h"
@interface SNOtherGoodsView ()

@end

@implementation SNOtherGoodsView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setOtherGoodsArray:(NSArray *)otherGoodsArray
{
    _otherGoodsArray = otherGoodsArray;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SNScreenBounds.width, 1)];
    [lineView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:lineView];
    CGFloat margin = 10;
    CGFloat lineMargin = 5;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(margin + 1, margin, SNScreenBounds.width - 2 * margin, 20)];
    label.text = @"这个商家的其他商品";
    [self addSubview:label];
        
    for (NSInteger index = 0; index < [otherGoodsArray count]; index ++) {
        CGFloat y = CGRectGetMaxY(label.frame) + (index + 1) * lineMargin;
        SNOtherGoodsLabelView *view = [[SNOtherGoodsLabelView alloc] init];
        [view setFrame:CGRectMake(margin, y, SNScreenBounds.width - 2 * margin, 20)];
        view.data = otherGoodsArray[index];
        [self addSubview:view];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat maxY = 0;
    for (SNOtherGoodsLabelView *view in self.subviews) {
        if (CGRectGetMaxY(view.frame) > maxY) {
            maxY = CGRectGetMaxY(view.frame);
        }
    }
    
    [self setFrame:CGRectMake(0, self.y, SNScreenBounds.width, maxY + 10)];
}

@end
