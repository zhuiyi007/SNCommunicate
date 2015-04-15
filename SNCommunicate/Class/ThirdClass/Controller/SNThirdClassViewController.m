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
#import "SNThirdClassNullCell.h"

@interface SNThirdClassViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SNThirdCellData *data;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *ret_msg;

@end

@implementation SNThirdClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:SNMainBackgroundColor];
    
    [self createUI];
    
    [self setData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI
{
    SNMainTableView *tableView = [[SNMainTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)setData
{
    [SNHttpTool getBusinessWithType:self.type finish:^(NSDictionary *responseObject) {
        SNLog(@"%@",responseObject);
        
        if (!responseObject[@"result"]) {
            self.ret_msg = responseObject[@"ret_msg"];
            [self.tableView reloadData];
            CGFloat height = [self countHeightWithTableView:self.tableView];
            if (height < SNScreenBounds.height) {
                height = SNScreenBounds.height;
            }
            [self.tableView setFrame:CGRectMake(0, 0, SNScreenBounds.width, height)];
            return;
        }
        
        _dataArray = [SNThirdCellData dataWithDict:responseObject].result;
        
        [self.tableView reloadData];
        CGFloat height = [self countHeightWithTableView:self.tableView];
        if (height < SNScreenBounds.height - 49) {
            height = SNScreenBounds.height - 49;
        }
        [self.tableView setFrame:CGRectMake(0, 0, SNScreenBounds.width, height)];
        
    } error:^(NSError *error) {
        SNLog(@"SNThirdClassViewController---%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self.dataArray count]) {
        return 1;
    }
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.ret_msg) {
        SNThirdClassNullCell *cell = [SNThirdClassNullCell createCellWithIdentifier:nil];
        cell.textLabel.text = self.ret_msg;
        return cell;
    }
    NSString *identifier = @"SNEntertainmentCell";
    SNThirdClassCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [SNThirdClassCell createCellWithIdentifier:identifier];
    }
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SNThirdClassViewController *vc = [[SNThirdClassViewController alloc] init];
//    vc.title = [self.dataArray[indexPath.row] title];
//    vc.type = vc.title;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.dataArray count]) {
        return 44;
    }
    return 130;
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

- (void)dealloc
{
    SNLog(@"-------dealloc------");
    SNLog(@"=======%s======", __func__);
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