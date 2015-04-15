//
//  SNSecondClassCell.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSecondCellData.h"

@interface SNSecondClassCell : UITableViewCell

@property (nonatomic, strong) SNSecondCellData *data;

+ (SNSecondClassCell *)createCellWithIdentifier:(NSString *)identify;

@end
