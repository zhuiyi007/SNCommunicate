//
//  SNRoundPlayScrollView.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/8.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNRoundPlayScrollView.h"
@interface SNRoundPlayScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger count;
@end

@implementation SNRoundPlayScrollView

+ (SNRoundPlayScrollView *)createRoundPlayScrollViewWithFrame:(CGRect)frame placeholderImage:(NSString *)placeholderImage
{
    SNRoundPlayScrollView *scrollView = [[self alloc] initWithFrame:frame];
    return scrollView;
}


- (void)insertImageWithImagesURLArray:(NSArray *)imagesURLArray placeholderImage:(NSString *)placeholderImage
{
    CGFloat width = self.width;
    CGFloat height = self.height;
    NSInteger count = [imagesURLArray count];
    self.count = count;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    
    [self startTimer];
    
    [self setContentSize:CGSizeMake(width * count, 0)];
    for (NSInteger index = 0; index < count; index ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        imageView.x = index * width;
        imageView.y = 0;
        [imageView setContentMode:UIViewContentModeScaleToFill];
        [imageView sd_setImageWithURL:imagesURLArray[index] placeholderImage:[UIImage imageNamed:placeholderImage]];
        [self addSubview:imageView];
    }
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = count;
    [self addSubview:self.pageControl];
    self.pageControl.centerX = self.contentOffset.x + self.width * 0.5;
    self.pageControl.y = self.height - 10;
}

- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:1
                                               target:self
                                             selector:@selector(nextImage)
                                             userInfo:nil
                                              repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer
                              forMode:NSRunLoopCommonModes];
}

- (void)endTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDecelerating:(SNRoundPlayScrollView *)scrollView
{
    [scrollView startTimer];
    scrollView.pageControl.currentPage = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;
}

- (void)scrollViewWillBeginDragging:(SNRoundPlayScrollView *)scrollView
{
    [scrollView endTimer];
}

- (void)scrollViewDidScroll:(SNRoundPlayScrollView *)scrollView
{
    self.pageControl.centerX = scrollView.contentOffset.x + scrollView.width * 0.5;
}


- (void)nextImage
{
    // 1.下一页
    if (self.pageControl.currentPage == self.count - 1) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage++;
    }
    
    // 2.设置滚动
    CGPoint offset = CGPointMake(self.width * self.pageControl.currentPage, 0);
    [self setContentOffset:offset animated:YES];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
