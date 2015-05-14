//
//  SNCustomerOrderCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNCustomerOrderCell.h"
@interface SNCustomerOrderCell()
/**
 *  订单号
 */
@property (nonatomic, strong) UILabel *orderNum;
/**
 *  顾客电话
 */
@property (nonatomic, strong) UILabel *customerTEL;
/**
 *  总价
 */
@property (nonatomic, strong) UILabel *totalPrice;
/**
 *  数量
 */
@property (nonatomic, strong) UILabel *Count;
/**
 *  完成订单按钮
 */
@property (nonatomic, strong) UIButton *finishOrder;

@property (nonatomic, strong) SNUserModel *userModel;

@end

@implementation SNCustomerOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.orderNum = [[UILabel alloc] init];
        [self addSubview:self.orderNum];
        
        self.customerTEL = [[UILabel alloc] init];
        [self addSubview:self.customerTEL];
        
        self.totalPrice = [[UILabel alloc] init];
        [self addSubview:self.totalPrice];
        
        self.Count = [[UILabel alloc] init];
        [self addSubview:self.Count];
        
        self.finishOrder = [[UIButton alloc] init];
        [self.finishOrder setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
        [self.finishOrder setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self.finishOrder setBackgroundColor:SNMainGreenColor];
        [self.finishOrder addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.finishOrder];
    }
    return self;
}

+ (SNCustomerOrderCell *)createCellWithIdentifier:(NSString *)identify
{
    SNCustomerOrderCell *cell = [[SNCustomerOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.backgroundColor = SNMainBackgroundColor;
    return cell;
}

- (SNUserModel *)userModel
{
    if (!_userModel) {
        _userModel = [SNUserModel sharedInstance];
    }
    return _userModel;
}

- (void)buttonClick
{
    [MBProgressHUD showMessage:@"请稍后"];
    [SNHttpTool completeDingDanWithPhoneNumber:self.userModel.phoneNumber passWord:self.userModel.passWord orderNumber:self.customerOrderModel.orderNum finish:^(id responseObject) {
        SNLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] integerValue] == 0) {
            [MBProgressHUD showError:responseObject[@"ret_msg"]];
            return;
        }
        [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
        [self.finishOrder setEnabled:NO];
        [self.finishOrder setTitle:@"已完成" forState:UIControlStateDisabled];
    } error:^(NSError *error) {
        SNLog(@"%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"操作失败"];
    }];
}

- (void)setCustomerOrderModel:(SNCustomerOrderModel *)customerOrderModel
{
    _customerOrderModel = customerOrderModel;
    self.orderNum.text = [NSString stringWithFormat:@"订单号:%@", customerOrderModel.orderNum];
    self.customerTEL.text = [NSString stringWithFormat:@"顾客电话:%@", customerOrderModel.customerTEL];
    self.totalPrice.text = [NSString stringWithFormat:@"价格:￥%@", customerOrderModel.totalPrice];
    self.Count.text = [NSString stringWithFormat:@"数量:%@", customerOrderModel.Count];
    [self.finishOrder setTitle:customerOrderModel.orderState forState:UIControlStateNormal & UIControlStateDisabled];
    if ([customerOrderModel.orderState isEqualToString:@"已完成"]) {
        [self.finishOrder setEnabled:NO];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    CGFloat lineMargin = 5;
    [self.orderNum setFrame:CGRectMake(margin, margin, 0, 0)];
    [self.orderNum sizeToFit];
    
    [self.customerTEL setFrame:CGRectMake(margin, CGRectGetMaxY(self.orderNum.frame) + lineMargin, 0, 0)];
    [self.customerTEL sizeToFit];
    
    [self.totalPrice setFrame:CGRectMake(margin, CGRectGetMaxY(self.customerTEL.frame) + lineMargin, 0, 0)];
    [self.totalPrice sizeToFit];
    
    [self.Count sizeToFit];
    [self.Count setFrame:CGRectMake(SNScreenBounds.width - margin - self.Count.width, margin, self.Count.width, self.Count.height)];
    
    [self.finishOrder sizeToFit];
    [self.finishOrder setFrame:CGRectMake(SNScreenBounds.width - self.finishOrder.width - margin - 20, CGRectGetMaxY(self.totalPrice.frame) - self.finishOrder.height, self.finishOrder.width + 20, self.finishOrder.height)];
    
}

@end
