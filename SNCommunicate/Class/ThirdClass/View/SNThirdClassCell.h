//
//  SNThirdClassCell.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNShopData.h"

@interface SNThirdClassCell : UITableViewCell

@property (nonatomic, strong) SNShopData *data;

+ (SNThirdClassCell *)createCellWithIdentifier:(NSString *)identify;

@end
