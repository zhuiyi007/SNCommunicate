//
//  SNDetailsViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNDetailsViewController.h"
#import "SNDetailsModel.h"
#import "SNDetailsScrollView.h"
#import "SNMainTableView.h"
#import "SNNullCell.h"

@interface SNDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SNDetailsScrollView *scrollView;
@property (nonatomic, strong) SNDetailsModel *detailsModel;
@property (nonatomic, strong) SNUserModel *userModel;


@end

@implementation SNDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:SNMainBackgroundColor];
    [self setData];
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
    self.scrollView = [[SNDetailsScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    // 预定收藏
    [self reserveView];
}

- (void)createNilUI
{
    SNMainTableView *tableView = [[SNMainTableView alloc] initWithFrame:SNTableViewFrame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
}

- (void)reserveView
{
    CGFloat height = 49;
    CGFloat width = SNScreenBounds.width * 0.5;
    CGFloat y = SNScreenBounds.height - 49 - 64;
    UIView *reserveView = [[UIView alloc] initWithFrame:CGRectMake(0, y, SNScreenBounds.width, height)];
    [reserveView setUserInteractionEnabled:YES];
    [self.view addSubview:reserveView];
    
    UIButton *reserveButton = [[UIButton alloc] init];
    [reserveButton setFrame:CGRectMake(0, 0, width, height)];
    [reserveButton setBackgroundColor:SNMainGreenColor];
    
    self.detailsData = self.detailsModel.result[0];
    if ([self.detailsData.yuDing isEqualToString:@"不可预订"]) {
        [reserveButton setEnabled:NO];
        [reserveButton setUserInteractionEnabled:NO];
    }
    [reserveButton setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
    [reserveButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [reserveButton.layer setMasksToBounds:YES];
    [reserveButton.layer setBorderWidth:2.0]; //边框宽度
    [reserveButton.layer setBorderColor:SNCGColor(119, 119, 119)]; //边框颜色
    [reserveButton setTitle:@"不可预订" forState:UIControlStateDisabled];
    [reserveButton setTitle:self.detailsData.yuDing forState:UIControlStateNormal];
    [reserveButton addTarget:self action:@selector(addReserve) forControlEvents:UIControlEventTouchUpInside];
    
    [reserveView addSubview:reserveButton];
    
    
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionButton setFrame:CGRectMake(width, 0, width, height)];
    [collectionButton setBackgroundColor:SNMainGreenColor];
    [collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectionButton setTitle:@"不可收藏" forState:UIControlStateDisabled];
    [collectionButton setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
    [collectionButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [collectionButton.layer setMasksToBounds:YES];
    [collectionButton.layer setBorderWidth:2.0]; //边框宽度
    [collectionButton.layer setBorderColor:SNCGColor(119, 119, 119)];//边框颜色
    [collectionButton addTarget:self action:@selector(addCollection) forControlEvents:UIControlEventTouchUpInside];
    [reserveView addSubview:collectionButton];
    
    if (self.userModel.phoneNumber.length == 8) {
        [reserveButton setEnabled:NO];
        [collectionButton setEnabled:NO];
    }
}

- (void)addReserve
{
    if (!self.userModel.login) {
        [MBProgressHUD showError:@"请登录后再操作"];
        return;
    }
    [MBProgressHUD showMessage:@"正在添加"];
    [SNHttpTool addDingDanWithShangID:self.detailsData.shangID
                          phoneNumber:self.userModel.phoneNumber
                             passWord:self.userModel.passWord
                                count:1
                            productID:[self.detailsData.ID integerValue]
                               finish:^(id responseObject) {
        SNLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue] == 0) {
           [MBProgressHUD hideHUD];
           [MBProgressHUD showError:responseObject[@"ret_msg"]];
            return;
        }
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
    }
                                error:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"添加失败"];
        SNLog(@"%@",error);
    }];
}

- (void)addCollection
{
    if (!self.userModel.login) {
        [MBProgressHUD showError:@"请登录后再操作"];
        return;
    }
    [MBProgressHUD showMessage:@"正在添加"];
    [SNHttpTool insertCollectionWithShangID:self.detailsData.shangID passWord:self.userModel.passWord phoneNumber:self.userModel.phoneNumber shangName:self.detailsData.Name finish:^(id responseObject) {
        SNLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] integerValue] == 0) {
            [MBProgressHUD showError:responseObject[@"ret_msg"]];
            return;
        }
        [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
    } error:^(NSError *error) {
        SNLog(@"%@",error);
        [MBProgressHUD showError:@"加载失败"];
    }];
}

- (void)setData
{
    [MBProgressHUD showMessage:@"正在加载"];
    if (!self.userModel.login || self.userModel.phoneNumber.length == 8) {
        [SNHttpTool getShangInfoNoIdentityWithShangID:self.shopData.ID andType:self.shopData.Type Big:0 Small:0 finish:^(id responseObject) {
            [MBProgressHUD hideHUD];
            SNLog(@"%@",responseObject);
            self.detailsModel = [SNDetailsModel objectWithKeyValues:responseObject];
            if (self.detailsModel.ret_msg) {
                [self createNilUI];
                return;
            }
            [self createUI];
            self.scrollView.dataArray = self.detailsModel.result;
            self.scrollView.shopData = self.shopData;
        } error:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"加载失败"];
        }];
    }
    else {
        [SNHttpTool getShangInfoByIdentityWithShangID:self.shopData.ID andType:self.shopData.Type phoneNumber:self.userModel.phoneNumber passWord:self.userModel.passWord Big:0 Small:0 finish:^(id responseObject) {
            [MBProgressHUD hideHUD];
            SNLog(@"%@",responseObject);
            self.detailsModel = [SNDetailsModel objectWithKeyValues:responseObject];
            if ([self.detailsModel.status integerValue] == 0) {
                [self createNilUI];
                return;
            }
            [self createUI];
            self.scrollView.dataArray = self.detailsModel.result;
            self.scrollView.shopData = self.shopData;
        } error:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"加载失败"];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNNullCell *cell = [SNNullCell createCellWithIdentifier:nil];
    cell.textLabel.text = self.detailsModel.ret_msg;
    return cell;
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
