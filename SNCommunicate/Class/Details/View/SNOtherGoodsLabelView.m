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

@property (nonatomic, strong) UIImageView *image;
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
    self.image = [[UIImageView alloc] init];
    [self.image setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.image];
    
    self.name = [[UILabel alloc] init];
    [self addSubview:self.name];
    
    self.price = [[UILabel alloc] init];
    [self addSubview:self.price];
}

- (void)setData:(SNDetailsData *)data
{
    _data = data;
    NSURL *url = [NSURL URLWithString:data.Pic];
    [self.image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.image setFrame:CGRectMake(0, (self.height - 60) * 0.5, 100, 60)];
    
    [self.price sizeToFit];
    self.price.x = self.width - self.price.width;
    self.price.y = (self.height - self.price.height) * 0.5;
    
    [self.name sizeToFit];
    self.name.x = CGRectGetMaxX(self.image.frame) + 10;
    self.name.y = (self.height - self.name.height) * 0.5;
    self.name.width = self.width - CGRectGetMaxX(self.image.frame)  - self.price.width - 30;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
