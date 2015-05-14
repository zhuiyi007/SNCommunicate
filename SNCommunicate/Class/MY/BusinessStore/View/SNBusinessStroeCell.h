//
//  SNBusinessStroeCell.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/10.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNDetailsData.h"

@interface SNBusinessStroeCell : UITableViewCell

@property (nonatomic, strong) SNDetailsData *detailsData;
+ (SNBusinessStroeCell *)createCellWithIdentifier:(NSString *)identify;

@end
