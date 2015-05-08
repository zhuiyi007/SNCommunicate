//
//  SNRoundPlayScrollView.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/8.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNRoundPlayScrollView : UIScrollView

+ (instancetype)createRoundPlayScrollViewWithFrame:(CGRect)frame placeholderImage:(NSString *)placeholderImage;


- (void)insertImageWithImagesURLArray:(NSArray *)imagesURLArray placeholderImage:(NSString *)placeholderImage;

- (void)endTimer;

- (void)startTimer;

@end
