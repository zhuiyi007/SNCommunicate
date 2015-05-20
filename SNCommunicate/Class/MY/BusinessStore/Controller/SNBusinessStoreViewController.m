//
//  SNBusinessStoreViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/10.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNBusinessStoreViewController.h"
#import "SNDetailsData.h"
#import "SNDetailsModel.h"
#import "SNBusinessStroeCell.h"
#import "SNNullCell.h"

@interface SNBusinessStoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SNUserModel *userModel;
@property (nonatomic, strong) SNDetailsModel *detailsModel;
@property (nonatomic, strong) SNDetailsData *detailsData;
@property (nonatomic, strong) NSString *totalOrderNumber;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *totalOrderLabel;

@end

@implementation SNBusinessStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self setData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SNUserModel *)userModel
{
    if (!_userModel) {
        _userModel = [SNUserModel sharedInstance];
    }
    return _userModel;
}

- (void)setTotalOrderNumber:(NSString *)totalOrderNumber
{
    _totalOrderNumber = totalOrderNumber;
    NSString *str = [NSString stringWithFormat:@"历史订单已达%@单", totalOrderNumber];
    NSMutableAttributedString *attributerString = [[NSMutableAttributedString alloc]
                                                   initWithString:str];
    self.totalOrderLabel.textAlignment = NSTextAlignmentCenter;
    [attributerString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont systemFontOfSize:24],
                                     NSFontAttributeName,
                                     SNColor(236, 73, 73),
                                     NSForegroundColorAttributeName,
                                     nil]
                              range:[str rangeOfString:totalOrderNumber]];
    
    // 设置富文本的段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 13.0f;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributerString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, str.length)];
    self.totalOrderLabel.attributedText = attributerString;
}

- (void)createUI
{
    // 设置金额的文本样式
    self.totalOrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SNScreenBounds.width, 50)];
    self.totalOrderNumber = @"...";
    
    
    self.tableView = [[SNMainTableView alloc] init];
    self.tableView.frame = SNTableViewFrame;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = self.totalOrderLabel;
    
    [self.view addSubview:self.tableView];
}

- (void)setData
{
    [MBProgressHUD showMessage:@"正在加载"];
    [SNHttpTool getShangPinByLoginNum:self.userModel.phoneNumber finish:^(id responseObject) {
        SNLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        self.detailsModel = [SNDetailsModel objectWithKeyValues:responseObject];
        if ([self.detailsModel.result count]) {
            self.detailsData = self.detailsModel.result[0];
            [self getTotalOrderNumber];
        }
        if ([self.detailsModel.status integerValue] == 0) {
            [MBProgressHUD showError:self.detailsModel.ret_msg];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        SNLog(@"%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败"];
    }];
}

- (void)getTotalOrderNumber
{
    [SNHttpTool getTotalDingDanWithShangID:self.detailsData.shangID finish:^(id responseObject) {
        SNLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 0) {
            self.totalOrderLabel.text = @"历史订单数获取失败";
            return;
        }
        self.totalOrderNumber = responseObject[@"ret_msg"];
    } error:^(NSError *error) {
        SNLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.detailsModel.result count] == 0) { // 没有已完成订单
        return 1;
    }
    else {
        return [self.detailsModel.result count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 有内容时显示的cell
    NSString *Cell = @"businessOrderCell";
    SNBusinessStroeCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (!cell) {
        cell = [SNBusinessStroeCell createCellWithIdentifier:Cell];
    }
    // 没有内容的cell
    SNNullCell *nullCell = [SNNullCell createCellWithIdentifier:nil];
    if ([self.detailsModel.result count] == 0) { // 没有商品
        nullCell.textLabel.text = @"暂时没有商品";
        return nullCell;
    }
    else {
        cell.detailsData = self.detailsModel.result[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.detailsModel.result count] == 0) { // 没有商品
        return 44;
    }
    return 92;
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
