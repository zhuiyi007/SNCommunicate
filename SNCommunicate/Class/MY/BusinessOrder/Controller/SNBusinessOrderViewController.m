//
//  SNBusinessOrderViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/9.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNBusinessOrderViewController.h"
//#import "SNBusinessOrder.h"
//#import "SNBusinessOrderModel.h"
//#import "SNBusinessOrderCell.h"
#import "SNNullCell.h"



#import "SNCustomerOrder.h"
#import "SNCustomerOrderModel.h"
#import "SNCustomerOrderCell.h"

@interface SNBusinessOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SNUserModel *userModel;

@property (nonatomic, strong) SNCustomerOrder *customerOrder;


@property (nonatomic, strong) NSArray *finishedOrder;
@property (nonatomic, strong) NSArray *unFinishedOrder;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SNBusinessOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:SNMainBackgroundColor];
    [self setData];
    [self createUI];
    // Do any additional setup after loading the view.
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
    [SNHttpTool selectDingDanByLoginNum:self.userModel.phoneNumber passWord:self.userModel.passWord big:0 small:0 finish:^(id responseObject) {
        SNLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        self.customerOrder = [SNCustomerOrder objectWithKeyValues:responseObject];
        if ([self.customerOrder.status integerValue] == 0) {
            [MBProgressHUD showError:self.customerOrder.ret_msg];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        SNLog(@"%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败"];
    }];
}

- (void)setCustomerOrder:(SNCustomerOrder *)customerOrder
{
    _customerOrder = customerOrder;
    NSMutableArray *finishedOrder = [NSMutableArray array];
    NSMutableArray *unFinishedOrder = [NSMutableArray array];
    for (SNCustomerOrderModel *model in customerOrder.result) {
        SNLog(@"%@", model.orderState);
        if ([model.orderState isEqualToString:@"已完成"]) {
            [finishedOrder addObject:model];
        }
        else {
            [unFinishedOrder addObject:model];
        }
    }
    self.finishedOrder = finishedOrder;
    self.unFinishedOrder = unFinishedOrder;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isFinishedOrder) { // 进入的是已出售订单
        if ([self.finishedOrder count] == 0) { // 没有已完成订单
            return 1;
        }
        else {
            return [self.finishedOrder count];
        }
    }
    else { // 进入的是待处理订单
        if ([self.unFinishedOrder count] == 0) { // 没有待处理订单
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
    NSString *Cell = @"businessOrderCell";
    SNCustomerOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (!cell) {
        cell = [SNCustomerOrderCell createCellWithIdentifier:Cell];
    }
    // 没有内容的cell
    SNNullCell *nullCell = [SNNullCell createCellWithIdentifier:nil];
    if (self.isFinishedOrder) { // 进入的是已出售订单
        if ([self.finishedOrder count] == 0) { // 没有已出售订单
            nullCell.textLabel.text = @"没有已出售订单";
            return nullCell;
        }
        else {
            cell.customerOrderModel = self.finishedOrder[indexPath.row];
            return cell;
        }
    }
    else { // 进入的是未完成订单
        if ([self.unFinishedOrder count] == 0) { // 没有待完成订单
            nullCell.textLabel.text = @"没有待处理订单";
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
    if (self.isFinishedOrder) { // 进入的是已出售订单
        if ([self.finishedOrder count] == 0) { // 没有已出售订单
            return 44;
        }
    }
    else { // 进入的是待完成订单
        if ([self.unFinishedOrder count] == 0) { // 没有待完成订单
            return 44;
        }
    }
    return 92;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isFinishedOrder) { // 进入的是已完成订单
        if ([self.finishedOrder count] > 0) { // 有已完成订单
            [self makePhoneCallWithPhoneNumber:[self.finishedOrder[indexPath.row] customerTEL]];
        }
    }
    else { // 进入的是未完成订单
        if ([self.unFinishedOrder count] > 0) { // 有未完成订单
            [self makePhoneCallWithPhoneNumber:[self.unFinishedOrder[indexPath.row] customerTEL]];
        }
    }
}

- (void)makePhoneCallWithPhoneNumber:(NSString *)phoneNumber
{
    SNLog(@"点击了电话按钮%@", phoneNumber);
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
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
