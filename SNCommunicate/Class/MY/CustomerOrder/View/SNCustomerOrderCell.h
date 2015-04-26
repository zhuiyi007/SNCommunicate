//
//  SNCustomerOrderCell.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCustomerOrderModel.h"

@interface SNCustomerOrderCell : UITableViewCell

@property (nonatomic, strong) SNCustomerOrderModel *customerOrderModel;

+ (SNCustomerOrderCell *)createCellWithIdentifier:(NSString *)identify;

@end
