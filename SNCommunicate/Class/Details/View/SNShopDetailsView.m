//
//  SNShopDetailsView.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNShopDetailsView.h"
#import "SNDetailsScrollView.h"

@interface SNShopDetailsView ()
/**
 *  分割线
 */
@property (nonatomic, strong) UIView *lineView;
/**
 *  商家名称
 */
@property (nonatomic, strong) UILabel *shopName;
/**
 *  电话
 */
@property (nonatomic, strong) UILabel *shopTEL;
/**
 *  地址
 */
@property (nonatomic, strong) UILabel *shopAddress;
/**
 *  级别
 */
@property (nonatomic, strong) UILabel *shopLevel;
/**
 *  类型
 */
@property (nonatomic, strong) UILabel *shopType;
/**
 *  简介
 */
@property (nonatomic, strong) UILabel *shopDetail;
/**
 *  父控件
 */
@property (nonatomic, strong) SNDetailsScrollView *superView;

@end

@implementation SNShopDetailsView

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
    self.lineView = [[UIView alloc] init];
    [self.lineView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.lineView];
    
    self.shopName = [[UILabel alloc] init];
    self.shopName.numberOfLines = 0;
    [self addSubview:self.shopName];
    
    self.shopTEL = [[UILabel alloc] init];
    self.shopTEL.numberOfLines = 0;
    [self addSubview:self.shopTEL];
    
    self.shopAddress = [[UILabel alloc] init];
    self.shopAddress.numberOfLines = 0;
    [self addSubview:self.shopAddress];
    
    self.shopLevel = [[UILabel alloc] init];
    self.shopLevel.numberOfLines = 0;
    [self addSubview:self.shopLevel];
    
    self.shopType = [[UILabel alloc] init];
    self.shopType.numberOfLines = 0;
    [self addSubview:self.shopType];
    
    self.shopDetail = [[UILabel alloc] init];
    self.shopDetail.numberOfLines = 0;
    [self addSubview:self.shopDetail];
}

- (void)setShopData:(SNShopData *)shopData
{
    _shopData = shopData;
    self.shopName.text = [NSString stringWithFormat:@"商家名称:%@",shopData.Name];
    self.shopTEL.text = [NSString stringWithFormat:@"   电话:%@",shopData.TEL];
    self.shopAddress.text = [NSString stringWithFormat:@"   地址:%@",shopData.Address];
    self.shopLevel.text = [NSString stringWithFormat:@"   级别:%@",shopData.Level];
    self.shopType.text = [NSString stringWithFormat:@"   类型:%@",shopData.Type];
    self.shopDetail.text = [NSString stringWithFormat:@"   简介:%@",shopData.Introduction];
    self.superView = (SNDetailsScrollView *)self.superview;
    [self setNeedsLayout];
}

#warning 待调整
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    CGFloat lineMargin = 5;
    CGFloat width = SNScreenBounds.width - 2 * margin;
    
    [self.lineView setFrame:CGRectMake(0, 0, SNScreenBounds.width, 1)];
    
    [self.shopName setFrame:CGRectMake(margin, CGRectGetMaxY(self.lineView.frame) + margin, width, 0)];
    [self.shopName sizeToFit];
    
    [self.shopTEL setFrame:CGRectMake(margin, CGRectGetMaxY(self.shopName.frame) + lineMargin, width, 0)];
    [self.shopTEL sizeToFit];
    
    [self.shopAddress setFrame:CGRectMake(margin, CGRectGetMaxY(self.shopTEL.frame) + lineMargin, width, 0)];
    [self.shopAddress sizeToFit];
    
    [self.shopLevel setFrame:CGRectMake(margin, CGRectGetMaxY(self.shopAddress.frame) + lineMargin, width, 0)];
    [self.shopLevel sizeToFit];
    
    [self.shopType setFrame:CGRectMake(margin, CGRectGetMaxY(self.shopLevel.frame) + lineMargin, width, 0)];
    [self.shopType sizeToFit];
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]};
    
    CGRect rect = [self.shopData.Introduction boundingRectWithSize:CGSizeMake(width, NSIntegerMax) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    [self.shopDetail setFrame:CGRectMake(margin, CGRectGetMaxY(self.shopType.frame) + lineMargin, width, rect.size.height)];
    
    [self setFrame:CGRectMake(0, self.y, SNScreenBounds.width, CGRectGetMaxY(self.shopDetail.frame) + margin)];
    
    self.superView.shopDetailsViewHeight = self.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
