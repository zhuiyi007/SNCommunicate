//
//  SNDetailsViewController.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNShopData.h"
#import "SNDetailsData.h"

@interface SNDetailsViewController : SNBaseViewController
@property (nonatomic, strong) SNShopData *shopData;
@property (nonatomic, strong) SNDetailsData *detailsData;

@end
