//
//  SNMainTextField.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/17.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMainTextField.h"
#import "AppDelegate.h"

@interface SNMainTextField ()<UITextFieldDelegate>
//初始frame
@property (assign, nonatomic) CGRect originalFrame;
@property (nonatomic, strong) UIView *superView;

@end

@implementation SNMainTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _originalFrame = frame;
}

/**
 *  键盘将要显示
 *
 *  @param notification 通知对象
 */
- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self getSuperViewWithView:self];
    //如果self在键盘之下 才做偏移
    CGFloat convertY = [self convertYToWindow:CGRectGetMaxY(self.originalFrame)];
    if (convertY >= _keyboardRect.origin.y) {
        //没有偏移 就说明键盘没出来，使用动画
        if (self.y == self.originalFrame.origin.y) {
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                self.superView.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height + SNScreenBounds.height - convertY);
            } completion:nil];
        }
        else {
            self.superView.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height + SNScreenBounds.height - convertY);
        }
    }
    else {
        return;
    }
}

/**
 *  键盘将要隐藏
 *
 *  @param notification 通知对象
 */
- (void)keyboardWillHide:(NSNotification*)notification
{
    [self getSuperViewWithView:self];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.superView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
}

/**
 *  windowY -> superViewY
 *
 *  @param Y window的Y
 *
 *  @return superView的Y
 */
- (CGFloat)convertYFromWindow:(float)Y
{

    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self];
    return o.y;
}

/**
 *  superViewY -> windowY
 *
 *  @param Y superView的Y
 *
 *  @return window的Y
 */
- (CGFloat)convertYToWindow:(float)Y
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [self convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return o.y;
}

- (void)getSuperViewWithView:(UIView *)view
{
    UIView *superView = [view superview];
    if ([superView superview] == nil) {
        self.superView = superView;
    }
    else
    {
        [self getSuperViewWithView:superView];
    }
}





@end
