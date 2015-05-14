//
//  SNBusinessOrderCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/9.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNBusinessOrderCell.h"
@interface SNBusinessOrderCell()
/**
 *  订单号
 */
@property (nonatomic, strong) UILabel *orderNumber;
/**
 *  商品ID
 */
@property (nonatomic, strong) UILabel *goodsID;
/**
 *  订单时间
 */
@property (nonatomic, strong) UILabel *orderTime;
/**
 *  订单数量
 */
@property (nonatomic, strong) UILabel *count;
/**
 *  顾客电话
 */
@property (nonatomic, strong) UILabel *customerTEL;
/**
 *  总价
 */
@property (nonatomic, strong) UILabel *totalPrice;

@end

@implementation SNBusinessOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

+ (SNBusinessOrderCell *)createCellWithIdentifier:(NSString *)identify
{
    SNBusinessOrderCell *cell = [[SNBusinessOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.backgroundColor = SNMainBackgroundColor;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.orderNumber = [[UILabel alloc] init];
        [self.contentView addSubview:self.orderNumber];
        
        self.goodsID = [[UILabel alloc] init];
        [self.contentView addSubview:self.goodsID];
        
        self.orderTime = [[UILabel alloc] init];
        [self.contentView addSubview:self.orderTime];
        
        self.count = [[UILabel alloc] init];
        [self.contentView addSubview:self.count];
        
        self.customerTEL = [[UILabel alloc] init];
        [self.contentView addSubview:self.customerTEL];
        
        self.totalPrice = [[UILabel alloc] init];
        [self.contentView addSubview:self.totalPrice];
    }
    return self;
}

- (void)setBusinessOrderModel:(SNBusinessOrderModel *)businessOrderModel
{
    _businessOrderModel = businessOrderModel;
    
    self.orderNumber.text = [NSString stringWithFormat:@"订单号:%@", businessOrderModel.orderNum];
    
    self.goodsID.text = [NSString stringWithFormat:@"商品ID:%@", businessOrderModel.shangID];
    
    self.orderTime.text = [NSString stringWithFormat:@"订单时间:%@", businessOrderModel.orderDate];
    
    self.count.text = [NSString stringWithFormat:@"数量:%@", businessOrderModel.Count];
    
    self.customerTEL.text = [NSString stringWithFormat:@"电话:%@", businessOrderModel.customerTEL];
    
    self.totalPrice.text = [NSString stringWithFormat:@"总价:%@", businessOrderModel.totalPrice];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    CGFloat lineMargin = 5;
    [self.orderNumber setFrame:CGRectMake(margin, margin, 0, 0)];
    [self.orderNumber sizeToFit];
    
    [self.goodsID setFrame:CGRectMake(margin, CGRectGetMaxY(self.orderNumber.frame) + lineMargin, 0, 0)];
    [self.goodsID sizeToFit];
    
    [self.orderTime setFrame:CGRectMake(margin, CGRectGetMaxY(self.goodsID.frame) + lineMargin, 0, 0)];
    [self.orderTime sizeToFit];
    
    [self.count sizeToFit];
    [self.count setFrame:CGRectMake(SNScreenBounds.width - margin - self.count.width, margin, self.count.width, self.count.height)];
    
    [self.customerTEL sizeToFit];
    [self.customerTEL setFrame:CGRectMake(SNScreenBounds.width - margin - self.customerTEL.width, CGRectGetMaxY(self.count.frame) + lineMargin, self.customerTEL.width, self.customerTEL.height)];
    
    [self.totalPrice sizeToFit];
    [self.totalPrice setFrame:CGRectMake(SNScreenBounds.width - margin - self.totalPrice.width, CGRectGetMaxY(self.customerTEL.frame) + lineMargin, self.totalPrice.width, self.totalPrice.height)];
}


@end
