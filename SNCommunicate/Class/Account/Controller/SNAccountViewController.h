//
//  SNAccountViewController.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNAccountViewController;

@protocol SNAccountViewControllerDelegate <NSObject>

- (void)accountViewControllerHiddenTabBar:(SNAccountViewController *)accountViewController;

@end

@interface SNAccountViewController : UIViewController

@property (nonatomic, weak) id<SNAccountViewControllerDelegate> delegate;

@end
