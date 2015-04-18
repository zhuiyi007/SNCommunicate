//
//  SNDetailsScrollView.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNDetailsData.h"
#import "SNShopData.h"

@interface SNDetailsScrollView : UIScrollView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) SNShopData *shopData;


@property (nonatomic, assign) CGFloat goodsDetailsViewHeight;
@property (nonatomic, assign) CGFloat shopDetailsViewHeight;

@end
