//
//  SNMYViewController.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNMYViewController;

@protocol SNMYViewControllerDelegate <NSObject>

- (void)myViewControllerHiddenTabBar:(SNMYViewController *)myViewController;

@end

@interface SNMYViewController : UIViewController

@property (nonatomic, weak) id<SNMYViewControllerDelegate> delegate;

@end


