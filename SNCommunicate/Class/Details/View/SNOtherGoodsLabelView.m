//
//  SNOtherGoodsLabelView.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNOtherGoodsLabelView.h"
#import "SNDetailsScrollView.h"
#import "SNDetailsViewController.h"

@interface SNOtherGoodsLabelView ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;

@end

@implementation SNOtherGoodsLabelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.name = [[UILabel alloc] init];
    [self addSubview:self.name];
    
    self.price = [[UILabel alloc] init];
    [self addSubview:self.price];
}

- (void)setData:(SNDetailsData *)data
{
    _data = data;
    self.name.text = data.Name;
    self.price.text = data.unitPrice;
    [self setNeedsLayout];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view = [self superview]; view; view = [view superview]) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[SNDetailsViewController class]]) {
            SNDetailsViewController *tempController = (SNDetailsViewController *)nextResponder;
            tempController.detailsData = self.data;
        }
        if ([view isKindOfClass:[SNDetailsScrollView class]]) {
            SNDetailsScrollView *tempView = (SNDetailsScrollView *)view;
            tempView.clickedDetail = self.data;
        }
    }
}

- (void)viewController {
    for (UIView *view = [self superview]; view; view = [view superview]) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[SNDetailsViewController class]]) {
            SNDetailsViewController *tempController = (SNDetailsViewController *)nextResponder;
            tempController.detailsData = self.data;
        }
        if ([view isKindOfClass:[SNDetailsScrollView class]]) {
            SNDetailsScrollView *tempView = (SNDetailsScrollView *)view;
            tempView.clickedDetail = self.data;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.name setFrame:CGRectZero];
    [self.name sizeToFit];
    
    [self.price sizeToFit];
    CGFloat width = self.price.width;
    CGFloat height = self.price.height;
    [self.price setFrame:CGRectMake(self.width - width, 0, width, height)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
