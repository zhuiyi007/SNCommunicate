//
//  SNMainCell.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNMainCellData.h"

@interface SNMainCell : UITableViewCell

@property (nonatomic, strong) SNMainCellData *data;

+ (SNMainCell *)createCellWithIdentifier:(NSString *)identify;

@end
