//
//  SNThirdClassViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNThirdClassViewController.h"
#import "SNShopData.h"
#import "SNThirdCellData.h"
#import "SNThirdClassCell.h"
#import "SNDetailsViewController.h"
#import "MJRefresh.h"

@interface SNThirdClassViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SNThirdCellData *data;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *ret_msg;

@end

@implementation SNThirdClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
    [self loadMoreDatas];
    
    [self setRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)createUI
{
    SNMainTableView *tableView = [[SNMainTableView alloc] init];
    tableView.frame = SNTableViewFrame;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    [self.tableView.footer setBackgroundColor:SNMainBackgroundColor];
    [self.view addSubview:tableView];
    
}

- (void)setRefresh
{
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    self.tableView.footer.automaticallyRefresh = NO;
}

- (void)loadMoreDatas
{
    NSInteger startIndex = [[[self.dataArray lastObject] rowNum] integerValue] + 1;
    NSInteger pageSize = startIndex + 20;
    if (![self.dataArray count]) {
        [MBProgressHUD showMessage:@"正在加载"];
        startIndex = 0;
        pageSize = 20;
    }
    [SNHttpTool getBusinessWithType:self.type
                         startIndex:startIndex
                           pageSize:pageSize
                             finish:^(NSDictionary *responseObject) {
                                 [MBProgressHUD hideHUD];
                                 SNLog(@"%@",responseObject);
                                 self.data = [SNThirdCellData objectWithKeyValues:responseObject];
                                 if ([self.data.status integerValue] == 0) {
                                     [self.tableView.footer noticeNoMoreData];
                                     return;
                                 }
                                 [self.dataArray addObjectsFromArray:self.data.result];
                                 SNLog(@"-----------%zd---------", [self.dataArray count]);
                                 [self.tableView reloadData];
                                 [self.tableView.footer endRefreshing];
                             } error:^(NSError *error) {
                                 [MBProgressHUD hideHUD];
                                 [MBProgressHUD showError:@"加载失败"];
                                 self.ret_msg = @"加载失败";
                                 [self.tableView reloadData];
                                 SNLog(@"SNThirdClassViewController---%@",error);
                             }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SNEntertainmentCell";
    SNThirdClassCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [SNThirdClassCell createCellWithIdentifier:identifier];
    }
    cell.data = self.dataArray[indexPath.row];
    tableView.userInteractionEnabled = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.ret_msg) {
        return;
    }
    SNDetailsViewController *vc = [[SNDetailsViewController alloc] init];
    vc.title = [_dataArray[indexPath.row] Name];
    vc.shopData = _dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.dataArray count]) {
        return 44;
    }
    return 130;
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