//
//  SNCustomerOrderViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNCustomerOrderViewController.h"
#import "SNCustomerOrder.h"
#import "SNCustomerOrderModel.h"
#import "SNNullCell.h"
#import "SNCustomerOrderCell.h"

@interface SNCustomerOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SNUserModel *userModel;
@property (nonatomic, strong) SNCustomerOrder *customerOrder;
@property (nonatomic, strong) NSArray *unFinishedOrder;
@property (nonatomic, strong) NSArray *finishedOrder;

@end

@implementation SNCustomerOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:SNMainBackgroundColor];
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

- (void)setCustomerOrder:(SNCustomerOrder *)customerOrder
{
    _customerOrder = customerOrder;
    NSMutableArray *finishedOrder = [NSMutableArray array];
    NSMutableArray *unFinishedOrder = [NSMutableArray array];
    for (SNCustomerOrderModel *model in _customerOrder.result) {
        if ([model.orderState isEqualToString:@"未完成"]) {
            [unFinishedOrder addObject:model];
        }
        else {
            [finishedOrder addObject:model];
        }
    }
    self.unFinishedOrder = unFinishedOrder;
    self.finishedOrder = finishedOrder;
}

- (void)createUI
{
    SNMainTableView *tableView = [[SNMainTableView alloc] initWithFrame:SNTableViewFrame
                                                                  style:UITableViewStylePlain];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.contentInset = UIEdgeInsetsZero;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)setData
{
    [MBProgressHUD showMessage:@"正在加载"];
    [SNHttpTool selectDingDanWithPhoneNumber:self.userModel.phoneNumber passWord:self.userModel.passWord big:0 small:0 finish:^(id responseObject) {
        SNLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        self.customerOrder = [SNCustomerOrder objectWithKeyValues:responseObject];
        if (self.customerOrder.status == 0) {
            [MBProgressHUD showError:self.customerOrder.ret_msg];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        SNLog(@"%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isFinishedOrder) { // 进入的是已完成订单
        if ([self.finishedOrder count] == 0) { // 没有已完成订单
            return 1;
        }
        else {
            return [self.finishedOrder count];
        }
    }
    else { // 进入的是未完成订单
        if ([self.unFinishedOrder count] == 0) { // 没有未完成订单
            return 1;
        }
        else {
            return [self.unFinishedOrder count];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 有内容时显示的cell
    NSString *Cell = @"customerOrderCell";
    SNCustomerOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (!cell) {
        cell = [SNCustomerOrderCell createCellWithIdentifier:Cell];
    }
    // 没有内容的cell
    SNNullCell *nullCell = [SNNullCell createCellWithIdentifier:nil];
    if (self.isFinishedOrder) { // 进入的是已完成订单
        if ([self.finishedOrder count] == 0) { // 没有已完成订单
            nullCell.textLabel.text = @"没有已完成订单";
            return nullCell;
        }
        else {
            cell.customerOrderModel = self.finishedOrder[indexPath.row];
            return cell;
        }
    }
    else { // 进入的是未完成订单
        if ([self.unFinishedOrder count] == 0) { // 没有未完成订单
            nullCell.textLabel.text = @"没有未完成订单";
            return nullCell;
        }
        else {
            cell.customerOrderModel = self.unFinishedOrder[indexPath.row];
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isFinishedOrder) { // 进入的是已完成订单
        if ([self.finishedOrder count] == 0) { // 没有已完成订单
            return 44;
        }
    }
    else { // 进入的是未完成订单
        if ([self.unFinishedOrder count] == 0) { // 没有未完成订单
            return 44;
        }
    }
    return 92;
}



@end
