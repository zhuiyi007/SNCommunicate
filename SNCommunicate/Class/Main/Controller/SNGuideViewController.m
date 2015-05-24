//
//  SNGuideViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/24.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNGuideViewController.h"
#import "SNGuideCell.h"
#import "SNMainViewController.h"

@interface SNGuideViewController ()
@property (nonatomic, weak) UIImageView *guideView;
@property (nonatomic, weak) UIImageView *smallTextView;
@property (nonatomic, weak) UIImageView *largerTextView;

@property (nonatomic, assign) CGFloat lastOffsetX;
@end

static NSString *ID = @"guideCell";

@implementation SNGuideViewController

/*
 使用UICollectionView的条件
 1.传入布局,因为里面的cell位置是由我们决定
 2.注册UICollectionViewCell或者子类
 3.必须自定义UICollectionViewCell
 */

// self.view != self.collectionView

- (instancetype)init
{
    // UICollectionViewLayout 抽象类 没有具体的功能
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = SNScreenBounds;
    
    
    layout.minimumLineSpacing = 0;
    
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册ILGuideCell
    // 注册之后:就不需要我们手动创建cell,系统如果没有从缓存池里取出cell,就会自动创建,完全交给系统处理
    [self.collectionView registerClass:[SNGuideCell class] forCellWithReuseIdentifier:ID];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    
    // 添加guide
    UIImageView *guideView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_guide_1"]];
    _guideView = guideView;
    [self.collectionView addSubview:guideView];
}



// 返回一组有多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

// 返回每一个cell的样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SNGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"guide%ld",indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        SNMainViewController *mainViewController = [[SNMainViewController alloc] init];
        // 之前的跟控制器会销毁,如果之前的控制器在以后都不需要使用,就可以使用这种方式跳转
        [UIApplication sharedApplication].keyWindow.rootViewController = mainViewController;
    }
}

@end
