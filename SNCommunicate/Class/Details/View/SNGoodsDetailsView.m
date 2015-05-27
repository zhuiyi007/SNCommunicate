//
//  SNGoodsDetailsView.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNGoodsDetailsView.h"
#import "SNDetailsScrollView.h"
#import "SNRoundPlayScrollView.h"

@interface SNGoodsDetailsView()//<UIScrollViewDelegate>
/**
 *  分割线
 */
@property (nonatomic, strong) UIView *lineView;
/**
 *  头部图片
 */
@property (nonatomic, strong) SNRoundPlayScrollView *topScrollView;
/**
 *  商品名称
 */
@property (nonatomic, strong) UILabel *goodsName;
/**
 *  库存
 */
@property (nonatomic, strong) UILabel *store;
/**
 *  商品价格
 */
@property (nonatomic, strong) UILabel *goodsPrice;
/**
 *  商品原价
 */
@property (nonatomic, strong) UILabel *goodsDisCount;
/**
 *  商品详情
 */
@property (nonatomic, strong) UILabel *goodsDetails;
/**
 *  父控件
 */
@property (nonatomic, strong) SNDetailsScrollView *superView;
/**
 *  购买数量(暂时没有)
 */
//@property (nonatomic, strong) UILabel *goodsBuyCount;
/**
 *  评分(暂时没有)
 */
//@property (nonatomic, strong) UILabel *goodsGrade;



@end

@implementation SNGoodsDetailsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self goodsDetailsView];
    }
    return self;
}

- (void)goodsDetailsView
{
    self.topScrollView = [SNRoundPlayScrollView createRoundPlayScrollViewWithFrame:CGRectMake(0, 0, SNScreenBounds.width, 170) placeholderImage:@"default_ad_1"];
    [self addSubview:self.topScrollView];
    
    self.lineView = [[UIView alloc] init];
    [self.lineView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.lineView];
    
    self.goodsName = [[UILabel alloc] init];
    [self addSubview:self.goodsName];
    
    self.store = [[UILabel alloc] init];
    [self addSubview:self.store];
    
    self.goodsPrice = [[UILabel alloc] init];
    [self.goodsPrice setFont:[UIFont systemFontOfSize:24]];
    [self.goodsPrice setTextColor:SNPriceColor];
    [self addSubview:self.goodsPrice];
    
    self.goodsDisCount = [[UILabel alloc] init];
    [self addSubview:self.goodsDisCount];
    
    // 暂时没有
    //    self.goodsBuyCount = [[UILabel alloc] init];
    //    [goodsDetails addSubview:self.goodsBuyCount];
    //
    //    self.goodsGrade = [[UILabel alloc] init];
    //    [goodsDetails addSubview:self.goodsGrade];
    
    self.goodsDetails = [[UILabel alloc] init];
    self.goodsDetails.numberOfLines = 0;
    self.goodsDetails.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.goodsDetails];
    
}


- (void)setDetailsData:(SNDetailsData *)detailsData
{
    _detailsData = detailsData;
    
    [self.topScrollView insertImageWithImagesURLArray:@[detailsData.Pic, detailsData.Pic2, detailsData.Pic3] placeholderImage:@"default_ad_1"];
    
    self.goodsName.text = detailsData.Name;
    self.store.text = [NSString stringWithFormat:@"库存:%@件", detailsData.Store];
    self.goodsPrice.text = [NSString stringWithFormat:@"%@ 元", detailsData.unitPrice];
    
    NSString *disCountString = [NSString stringWithFormat:@"原价%@元", detailsData.disCount];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:disCountString];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, [disCountString length])];
    [self.goodsDisCount setAttributedText:attri];
    
    self.goodsDetails.text = [NSString stringWithFormat:@"商品详情\n%@", detailsData.Description];
    self.superView = (SNDetailsScrollView *)self.superview;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    CGFloat screenWidth = SNScreenBounds.width;
    CGFloat margin = 10;
    CGFloat width = 0;
    CGFloat height = 0;
    
    [self.lineView setFrame:CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), screenWidth, 1)];
    
    [self.goodsPrice sizeToFit];
    width = self.goodsPrice.width;
    height = self.goodsPrice.height;
    [self.goodsPrice setFrame:CGRectMake(screenWidth - width - 10, CGRectGetMaxY(self.lineView.frame) + margin, width, height)];
    
    [self.goodsName sizeToFit];
    [self.goodsName setFrame:CGRectMake(margin, CGRectGetMaxY(self.lineView.frame) + margin, self.width - self.goodsPrice.width - 3 * margin, self.goodsName.height)];
    
    [self.store setFrame:CGRectMake(margin, CGRectGetMaxY(self.goodsName.frame) + margin, 0, 0)];
    [self.store sizeToFit];
    
    
    [self.goodsDisCount sizeToFit];
    width = self.goodsDisCount.width;
    height = self.goodsDisCount.height;
    [self.goodsDisCount setFrame:CGRectMake(screenWidth - width - 10, CGRectGetMaxY(self.goodsPrice.frame) + margin, width, height)];
    
    [self.goodsDetails setFrame:CGRectMake(margin, CGRectGetMaxY(self.goodsDisCount.frame) + margin, screenWidth - 2 * margin, 0)];
    [self.goodsDetails sizeToFit];
    
    [self setFrame:CGRectMake(0, 0, screenWidth, CGRectGetMaxY(self.goodsDetails.frame) + margin)];
    
    self.superView.goodsDetailsViewHeight = self.height;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
