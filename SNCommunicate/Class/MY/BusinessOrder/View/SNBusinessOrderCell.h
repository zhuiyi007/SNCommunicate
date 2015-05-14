//
//  SNBusinessOrderCell.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/9.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNBusinessOrderModel.h"

@interface SNBusinessOrderCell : UITableViewCell

@property (nonatomic, strong) SNBusinessOrderModel *businessOrderModel;

+ (SNBusinessOrderCell *)createCellWithIdentifier:(NSString *)identify;

@end
