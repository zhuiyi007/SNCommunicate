//
//  SNMYViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMYViewController.h"
#import "SNAccountViewController.h"
#import "SNCustomerCollectionViewController.h"
#import "SNCustomerOrderViewController.h"
#import "SNBusinessOrderViewController.h"
#import "SNBusinessStoreViewController.h"
#import "SNMainCellData.h"
#import "SNMainCell.h"
#import "SNTabBar.h"

@interface SNMYViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) SNUserModel *userModel;

@property (nonatomic, assign) BOOL isChecking;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) SNMainTableView *tableView;

@property (nonatomic, assign) BOOL isCustomer;

@end

@implementation SNMYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[SNMainTableView alloc]
                                  initWithFrame:SNTableViewFrame
                                  style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self clickMyTabBar:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickMyTabBar:) name:SNClickMyTabBar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:SNLoginSuccess object:nil];
    [self showRightBarButtonItem];
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

- (void)clickMyTabBar:(NSNotification *)notification
{
    if (self.isChecking) {
        return;
    }
    UIStoryboard *accountStoryBoard = [UIStoryboard storyboardWithName:@"SNAccountViewController" bundle:nil];
    SNAccountViewController *account = [accountStoryBoard instantiateInitialViewController];
    if (![[NSFileManager defaultManager] fileExistsAtPath:SNUserInfoPath]) {
        // 本地没有缓存信息
        self.isChecking = YES;
        [self.navigationController pushViewController:account animated:YES];
    }
    else { // 本地有缓存信息,直接给服务器验证
        [SNArchiverManger unarchiveUserModel];
        [MBProgressHUD showMessage:@"正在验证身份"];
        if ([self.userModel.phoneNumber length] == 11) {
            [SNHttpTool customerLoginWithPhoneNumber:self.userModel.phoneNumber passWord:self.userModel.passWord finish:^(id responseObject) {
                [MBProgressHUD hideHUD];
                SNLog(@"%@", responseObject);
                if ([responseObject[@"status"] integerValue] == 0) {
                    // 验证不通过,跳到登录页面,并且删除本地缓存
                    [MBProgressHUD showError:responseObject[@"ret_msg"]];
                    [[NSFileManager defaultManager] removeItemAtPath:SNUserInfoPath error:nil];
                    [self.navigationController pushViewController:account animated:YES];
                    self.isChecking = YES;
                    return;
                }
                [MBProgressHUD showSuccess:@"验证成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:SNLoginSuccess object:nil];
                self.userModel.login = YES;
                self.isChecking = YES;
            } error:^(NSError *error) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"验证超时"];
                SNLog(@"%@", error);
            }];
        } else {
            [SNHttpTool businessLoginWithLoginNumber:self.userModel.phoneNumber passWord:self.userModel.passWord finish:^(id responseObject) {
                [MBProgressHUD hideHUD];
                SNLog(@"%@", responseObject);
                if ([responseObject[@"status"] integerValue] == 0) {
                    // 验证不通过,跳到登录页面,并且删除本地缓存
                    [MBProgressHUD showError:responseObject[@"ret_msg"]];
                    [[NSFileManager defaultManager] removeItemAtPath:SNUserInfoPath error:nil];
                    [self.navigationController pushViewController:account animated:YES];
                    self.isChecking = YES;
                    return;
                }
                [MBProgressHUD showSuccess:@"验证成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:SNLoginSuccess object:nil];
                self.userModel.login = YES;
                self.isChecking = YES;
            } error:^(NSError *error) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"验证超时"];
                SNLog(@"%@", error);
            }];
        }
    }
}

- (void)loginSuccess:(NSNotification *)notification
{
    if ([self.userModel.phoneNumber length] == 11) {
        // 顾客身份
        [self createCustomerUI];
        self.isCustomer = YES;
        self.title = self.userModel.name;
        [self.tableView reloadData];
    }
    else {
        // 商家身份
        [self createShopUI];
        self.isCustomer = NO;
        self.title = self.userModel.name;
        [self.tableView reloadData];
    }
}

- (void)createCustomerUI
{
    SNMainCellData *data1 = [[SNMainCellData alloc] init];
    data1.icon = @"my1";
    data1.title = @"我的收藏";
    SNMainCellData *data2 = [[SNMainCellData alloc] init];
    data2.icon = @"my2";
    data2.title = @"未完成订单";
    SNMainCellData *data3 = [[SNMainCellData alloc] init];
    data3.icon = @"my3";
    data3.title = @"已完成订单";
    _dataArray = [NSArray arrayWithObjects:data1, data2, data3, nil];
}

- (void)createShopUI
{
    SNMainCellData *data1 = [[SNMainCellData alloc] init];
    data1.title = @"已出售订单";
    SNMainCellData *data2 = [[SNMainCellData alloc] init];
    data2.title = @"待处理订单";
    SNMainCellData *data3 = [[SNMainCellData alloc] init];
    data3.icon = @"cangku";
    data3.title = @"库存";
    _dataArray = [NSArray arrayWithObjects:data1, data2, data3, nil];
}

- (void)showRightBarButtonItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"注销" forState:UIControlStateNormal];
    [button setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self
               action:@selector(rightBarButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)rightBarButtonPressed
{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"您真的要注销么?"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    else {
        [[NSFileManager defaultManager] removeItemAtPath:SNUserInfoPath error:nil];
        [SNUserModel clearUserModel];
        self.isChecking = NO;
        [self clickMyTabBar:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell = @"MYViewController";
    SNMainCell *cell = [SNMainCell createCellWithIdentifier:Cell];
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCustomer) {
        switch (indexPath.row) {
            case 0:
            {
                SNCustomerCollectionViewController *vc = [[SNCustomerCollectionViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                SNCustomerOrderViewController *vc = [[SNCustomerOrderViewController alloc] init];
                vc.title = @"未完成订单";
                vc.isFinishedOrder = NO;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
            {
                SNCustomerOrderViewController *vc = [[SNCustomerOrderViewController alloc] init];
                vc.title = @"已完成订单";
                vc.isFinishedOrder = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
        }
    }
    else {
        switch (indexPath.row) {
            case 0:
            {
                SNBusinessOrderViewController *vc = [[SNBusinessOrderViewController alloc] init];
                vc.title = @"已出售订单";
                vc.isFinishedOrder = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                SNBusinessOrderViewController *vc = [[SNBusinessOrderViewController alloc] init];
                vc.title = @"待处理订单";
                vc.isFinishedOrder = NO;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
            {
                SNBusinessStoreViewController *vc = [[SNBusinessStoreViewController alloc] init];
                vc.title = @"库存";
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
        }
    }
    [[SNTabBar tabBar] hiddenTabBar];
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
