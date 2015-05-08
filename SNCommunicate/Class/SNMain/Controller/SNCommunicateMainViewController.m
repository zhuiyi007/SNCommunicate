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

#import "SNTabBar.h"
#import "SNRoundPlayScrollView.h"

static NSInteger ImageCount = 4;

@interface SNCommunicateMainViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    self.scrollView = [SNRoundPlayScrollView createRoundPlayScrollViewWithRect:CGRectMake(0, 0, SNScreenBounds.width, 220) imagesURLArray:@[@"http://123.57.206.151:80/img/pro_1_31430821377.jpg", @"http://123.57.206.151:80/img/pro2_1_31430821377.jpg", @"http://123.57.206.151:80/img/pro3_1_31430821377.jpg"] placeholderImage:@"default_ad_1"];
    [self.view addSubview:self.scrollView];
    
    // TableView
    CGFloat tableViewY = CGRectGetMaxY(self.scrollView.frame);
    SNMainTableView *tableView = [[SNMainTableView alloc]
                                  initWithFrame:CGRectMake(0,
                                                           tableViewY,
                                                           SNScreenBounds.width,
                                                           SNScreenBounds.height - tableViewY)
                                                                  style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
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
    [[SNTabBar tabBar] hiddenTabBar];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
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
