//
//  SNCustomerCollectionViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNCustomerCollectionViewController.h"
#import "SNNullCell.h"
#import "SNCustomerCollect.h"
#import "SNCustomerCollectModel.h"

@interface SNCustomerCollectionViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SNCustomerCollect *customerCollect;
@property (nonatomic, strong) SNUserModel *userModel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIAlertView *alert;

@end

@implementation SNCustomerCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:SNMainBackgroundColor];
    self.title = @"我的收藏";
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
    
    [SNHttpTool selectCollectionWithPhoneNumber:self.userModel.phoneNumber passWord:self.userModel.passWord finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
        SNLog(@"%@", responseObject);
        self.customerCollect = [SNCustomerCollect objectWithKeyValues:responseObject];
        if (self.customerCollect.status == 0) {
            [MBProgressHUD showError:self.customerCollect.ret_msg];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败"];
        SNLog(@"%@", error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.customerCollect.result count] == 0) {
        return 1;
    }
    return [self.customerCollect.result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell = @"customerCollection";
    SNNullCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (!cell) {
        cell = [SNNullCell createCellWithIdentifier:Cell];
    }
    cell.textLabel.text = [self.customerCollect.result[indexPath.row] shangName];
    if ([self.customerCollect.result count] == 0) {
        cell.textLabel.text = self.customerCollect.ret_msg;
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.customerCollect.result count] > 0) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"确定要删除?"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"删除", nil];
        self.index = indexPath.row;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.tableView reloadData];
        return;
    }
    else {
        SNCustomerCollectModel *model = self.customerCollect.result[self.index];
        [MBProgressHUD showMessage:@"正在删除"];
        [SNHttpTool deleteCollectionWithID:model.ID phoneNumber:self.userModel.phoneNumber passWord:self.userModel.passWord finish:^(id responseObject) {
            SNLog(@"%@",responseObject);
            [MBProgressHUD hideHUD];
            if (self.customerCollect.status == 0) {
                [MBProgressHUD showError:responseObject[@"ret_msg"]];
            }
            [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
        } error:^(NSError *error) {
            SNLog(@"%@", error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"删除失败"];
        }];
        [self.customerCollect.result removeObjectAtIndex:self.index];
        [self.tableView reloadData];
        return;
    }
}


@end
