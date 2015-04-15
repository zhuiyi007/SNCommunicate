//
//  SNCommunicateMainViewController.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNCommunicateMainViewController;

@protocol SNCommunicateMainViewControllerDelegate <NSObject>

- (void)communicateMainViewControllerHiddenTabBar:(SNCommunicateMainViewController *)communicateMainViewController;

@end

@interface SNCommunicateMainViewController : UIViewController

@property (nonatomic, weak) id<SNCommunicateMainViewControllerDelegate> delegate;

@end
