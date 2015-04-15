//
//  SNCommunicateMainViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNCommunicateMainViewController.h"
#import "SNSecondClassViewController.h"

#import "SNMainCell.h"
#import "SNMainCellData.h"

const NSInteger ImageCount = 4;

@interface SNCommunicateMainViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SNCommunicateMainViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI界面搭建
- (void)createUI
{
    // UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SNScreenBounds.width, 220)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [self fillScrollView];
    
    self.timer = [NSTimer timerWithTimeInterval:3
                                         target:self
                                       selector:@selector(nextImage)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer
                              forMode:NSRunLoopCommonModes];
    
    // TableView
    SNMainTableView *tableView = [[SNMainTableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    CGFloat height = [self countHeightWithTableView:tableView];
    if (height < SNScreenBounds.height - CGRectGetMaxY(self.scrollView.frame)) {
        height = SNScreenBounds.height - CGRectGetMaxY(self.scrollView.frame);
    }
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), SNScreenBounds.width, height)];
    [self.view addSubview:tableView];
}

- (void)fillScrollView
{
    self.scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat imageW = SNScreenBounds.width;
    CGFloat imageH = 220;
    CGFloat imageY = 0;
    for (NSInteger index = 1; index <= ImageCount; index++) {
        CGFloat imageX = (index - 1) * imageW;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ktv%ld", (long)index]];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(imageW * ImageCount, 0);
    self.scrollView.pagingEnabled = YES;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.centerX = self.scrollView.centerX;
    pageControl.y = self.scrollView.height - 10;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    self.pageControl.numberOfPages = ImageCount;
}

- (void)nextImage
{
    // 1.下一页
    if (self.pageControl.currentPage == ImageCount - 1) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage++;
    }
    
    // 2.设置滚动
    CGPoint offset = CGPointMake(self.scrollView.frame.size.width * self.pageControl.currentPage, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        SNMainCellData *data1 = [[SNMainCellData alloc] init];
        data1.icon = @"xiuxianyule";
        data1.title = @"生活娱乐";
        SNMainCellData *data2 = [[SNMainCellData alloc] init];
        data2.icon = @"meishizhusu";
        data2.title = @"美食住宿";
        SNMainCellData *data3 = [[SNMainCellData alloc] init];
        data3.icon = @"jiankangmeirong";
        data3.title = @"健康美容";
        SNMainCellData *data4 = [[SNMainCellData alloc] init];
        data4.icon = @"xunbaoshangcheng";
        data4.title = @"寻宝商城";
        SNMainCellData *data5 = [[SNMainCellData alloc] init];
        data5.icon = @"shangchang";
        data5.title = @"商场";
        _dataArray = [NSArray arrayWithObjects:data1, data2, data3, data4, data5, nil];
    }
    return _dataArray;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.timer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.timer) return;
    self.pageControl.currentPage = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SNMainCell";
    SNMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [SNMainCell createCellWithIdentifier:identifier];
    }
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNSecondClassViewController *vc = [[SNSecondClassViewController alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            vc.title = @"生活娱乐";
            vc.plist = @"SNEntertainment";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            vc.title = @"美食住宿";
            vc.plist = @"SNEatAndBed";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            vc.title = @"健康美容";
            vc.plist = @"SNHealthAndBeauty";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            vc.title = @"寻宝商城";
            vc.plist = @"";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
        {
            vc.title = @"商场";
            vc.plist = @"SNMarket";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    }
    if ([self.delegate respondsToSelector:@selector(communicateMainViewControllerHiddenTabBar:)]) {
        [self.delegate communicateMainViewControllerHiddenTabBar:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

#pragma mark - 动态计算tableView高度
- (CGFloat)countHeightWithTableView:(UITableView *)tableView
{
    CGFloat tableViewHeight = 0.0;
    for (NSInteger row = 0; row < [self tableView:tableView numberOfRowsInSection:0]; row ++) {
        tableViewHeight += [self tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    }
    return tableViewHeight;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
