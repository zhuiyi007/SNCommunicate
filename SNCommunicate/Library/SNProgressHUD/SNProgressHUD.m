//
//  YCProgressHUD.m
//  YCProgressHUD
//
//  Created by gongliang on 13-11-20.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "SNProgressHUD.h"
//#import "UIViewExt.h"

@interface SNProgressHUD ()

@property (strong, nonatomic) UIView *bgView; //黑色背景

@property (strong, nonatomic) UIImageView *indicatorView; //白色转动

@property (strong, nonatomic) UIImageView *rodView; //白色点

@property (assign, nonatomic) BOOL isHide; //当动画时间小于1S让隐藏为NO

@end


@implementation SNProgressHUD {
    UIActivityIndicatorView *loading;
}

- (void)dealloc {
    //DLog(@"YC HUD dealloc");
}

+ (void)showHUDAddedTo:(UIView *)view {
    //显示之前 先判断当前view 时候已经加载过了，如果已经加载过，直接remove掉
    SNProgressHUD *lastHud = [self HUDForView:view];
    if (lastHud) {
        [lastHud removeFromSuperview];
    }

    SNProgressHUD *hud = [[self alloc] initWithView:view];
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
    [hud playAnimation];
}

+ (void)hideHUDForView:(UIView *)view {
    SNProgressHUD *hud = [self HUDForView:view];
    if (hud) {
        if (hud.isHide) {
            [hud hide];
        } else {
            [hud hide];
        }
    }
    [hud removeFromSuperview];
}

//初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isHide = NO;
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
        | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

        loading = [[UIActivityIndicatorView alloc] init];
        loading.color = [UIColor blackColor];
        CGRect bgFrame = CGRectMake(frame.size.width/2 -loading.width/2,
                                    frame.size.height/2 -loading.height/2,
                                    loading.width, loading.height);
        _bgView = [[UIView alloc] initWithFrame:bgFrame];
        loading.center = CGPointMake(_bgView.width/2.0,_bgView.height/2.0);
        _bgView.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:loading];
        
        [self addSubview:_bgView];
    }
    return self;
}

/**
 *  开始loading动画
 */
- (void)playAnimation {
    [loading startAnimating];
}

- (id)initWithView:(UIView *)view {
    return [self initWithFrame:view.bounds];
}

//隐藏动画
- (void)hide {
    [loading stopAnimating];
}

+ (SNProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (SNProgressHUD *)subview;
        }
    }
    return nil;
}

@end
