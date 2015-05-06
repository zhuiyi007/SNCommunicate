//
//  SNDetailsScrollView.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNDetailsScrollView.h"
#import "SNGoodsDetailsView.h"
#import "SNShopDetailsView.h"
#import "SNOtherGoodsView.h"

@interface SNDetailsScrollView ()
/**
 *  分割线
 */
@property (nonatomic, strong) UIView *lineView;
/**
 *  商品详情View
 */
@property (nonatomic, strong) SNGoodsDetailsView *goodsDetailsView;
/**
 *  商家详情View
 */
@property (nonatomic, strong) SNShopDetailsView *shopDetailsView;
/**
 *  其他商品View
 */
@property (nonatomic, strong) SNOtherGoodsView *otherGoodsView;
/**
 *  其他商品信息
 */
@property (nonatomic, strong) NSMutableArray *otherGoodsArray;


@end
@implementation SNDetailsScrollView

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
    
    // 商品详情View
    self.goodsDetailsView = [[SNGoodsDetailsView alloc] init];
    [self addSubview:self.goodsDetailsView];
    
    // 商家详情View
    self.shopDetailsView = [[SNShopDetailsView alloc] init];
    [self addSubview:self.shopDetailsView];
    
    // 其他商品View
    self.otherGoodsView = [[SNOtherGoodsView alloc] init];
    [self addSubview:self.otherGoodsView];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.goodsDetailsView.detailsData = self.dataArray[0];
    self.otherGoodsArray = [NSMutableArray array];
    for (NSInteger index = 1; index < [dataArray count]; index ++) {
        [self.otherGoodsArray addObject:dataArray[index]];
    }
    self.otherGoodsView.otherGoodsArray = self.otherGoodsArray;
    [self setNeedsLayout];
}

- (void)setShopData:(SNShopData *)shopData
{
    _shopData = shopData;
    self.shopDetailsView.shopData = shopData;
}

- (void)setGoodsDetailsViewHeight:(CGFloat)goodsDetailsViewHeight
{
    _goodsDetailsViewHeight = goodsDetailsViewHeight;
    [self setNeedsLayout];
}

- (void)setShopDetailsViewHeight:(CGFloat)shopDetailsViewHeight
{
    _shopDetailsViewHeight = shopDetailsViewHeight;
    [self setNeedsLayout];
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.shopDetailsView.y = CGRectGetMaxY(self.goodsDetailsView.frame);
    self.otherGoodsView.y = CGRectGetMaxY(self.shopDetailsView.frame);
    
    [self setFrame:CGRectMake(0, 0, SNScreenBounds.width, SNScreenBounds.height - 49)];
    [self setContentSize:CGSizeMake(0, CGRectGetMaxY(self.otherGoodsView.frame))];
}

@end
