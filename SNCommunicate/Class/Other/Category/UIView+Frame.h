//
//  UIView+Frame.h
//  Lottery
//
//  Created by ZhuiYi on 14-11-12.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 *  可以直接使用例如:view.x的方法,不必调用frame
 */
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
