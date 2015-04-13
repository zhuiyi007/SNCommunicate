//
//  SNMainNavigationController.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNMainNavigationController;
@protocol SNMainNavigationControllerDelegate <NSObject>

- (void)mainNavigationControllerShowTabBar:(SNMainNavigationController *)mainNavigationController;

@end

@interface SNMainNavigationController : UINavigationController

@property (nonatomic, weak) id<SNMainNavigationControllerDelegate> mainDelegate;

@end
