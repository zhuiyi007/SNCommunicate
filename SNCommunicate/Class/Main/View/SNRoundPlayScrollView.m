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


+ (instancetype)createRoundPlayScrollViewWithRect:(CGRect)rect imagesURLArray:(NSArray *)imagesURLArray placeholderImage:(NSString *)placeholderImage
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    NSInteger count = [imagesURLArray count];
    SNRoundPlayScrollView *scrollView = [[self alloc] init];
    scrollView.count = count;
    scrollView.delegate = scrollView;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    [scrollView startTimer];
    
    [scrollView setFrame:rect];
    [scrollView setContentSize:CGSizeMake(width * count, 0)];
    for (NSInteger index = 0; index < count; index ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        imageView.x = index * width;
        imageView.y = 0;
        [imageView setContentMode:UIViewContentModeScaleToFill];
        [imageView sd_setImageWithURL:imagesURLArray[index] placeholderImage:[UIImage imageNamed:placeholderImage]];
        [scrollView addSubview:imageView];
    }
    scrollView.pageControl = [[UIPageControl alloc] init];
    scrollView.pageControl.numberOfPages = count;
    [scrollView addSubview:scrollView.pageControl];
    scrollView.pageControl.centerX = scrollView.contentOffset.x + scrollView.width * 0.5;
    scrollView.pageControl.y = scrollView.height - 10;
    return scrollView;
}

- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:5
                                               target:self
                                             selector:@selector(nextImage)
                                             userInfo:nil
                                              repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer
                              forMode:NSRunLoopCommonModes];
}

- (void)scrollViewDidEndDecelerating:(SNRoundPlayScrollView *)scrollView
{
    [scrollView startTimer];
    scrollView.pageControl.currentPage = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;
}

- (void)scrollViewWillBeginDragging:(SNRoundPlayScrollView *)scrollView
{
    [scrollView.timer invalidate];
    scrollView.timer = nil;
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
