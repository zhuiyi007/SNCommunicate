//
//  UIViewController+YCCommon.h
//  iWeidao
//
//  Created by yongche on 13-11-8.
//  Copyright (c) 2013年 Weidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SNCommon)

@property (nonatomic,strong) UIImageView * homeShotImageV;


- (void)showProgressHUD;

- (void)hideProgressHUD;

- (void)showToastMessage:(NSString *)message;

@end








