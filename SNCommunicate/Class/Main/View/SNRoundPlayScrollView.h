//
//  SNRoundPlayScrollView.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/8.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNRoundPlayScrollView : UIScrollView

+ (instancetype)createRoundPlayScrollViewWithRect:(CGRect)rect imagesURLArray:(NSArray *)imagesURLArray placeholderImage:(NSString *)placeholderImage;

@end
