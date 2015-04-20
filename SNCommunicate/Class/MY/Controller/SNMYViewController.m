//
//  SNMYViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/19.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMYViewController.h"
#import "SNAccountViewController.h"

@interface SNMYViewController ()

@property (nonatomic, strong) SNUserModel *userModel;

@property (nonatomic, assign) BOOL isChecking;

@end

@implementation SNMYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    [self clickMyTabBar:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickMyTabBar:) name:SNClickMyTabBar object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickMyTabBar:(NSNotification *)notification
{
    if (self.isChecking) {
        return;
    }
    UIStoryboard *accountStoryBoard = [UIStoryboard storyboardWithName:@"SNAccountViewController" bundle:nil];
    SNAccountViewController *account = [accountStoryBoard instantiateInitialViewController];
    if (![[NSFileManager defaultManager] fileExistsAtPath:SNUserInfoPath]) {
        self.isChecking = YES;
        [self.navigationController pushViewController:account animated:YES];
    }
    else {
        [SNArchiverManger unarchiveUserModel];
        self.userModel = [SNUserModel sharedInstance];
        [MBProgressHUD showMessage:@"正在验证身份"];
        [SNHttpTool customerLoginWithPhoneNumber:self.userModel.phoneNumber
                                        passWord:self.userModel.passWord
                                          finish:^(id responseObject) {
            [MBProgressHUD hideHUD];
            SNLog(@"%@", responseObject);
            if ([responseObject[@"status"] integerValue] == 0) {
                [MBProgressHUD showError:responseObject[@"ret_msg"]];
                [[NSFileManager defaultManager] removeItemAtPath:SNUserInfoPath error:nil];
                [self.navigationController pushViewController:account animated:YES];
                self.isChecking = YES;
                return;
            }
            [MBProgressHUD showSuccess:@"验证成功"];
            self.isChecking = YES;
                                          }
                                           error:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"验证超时"];
            SNLog(@"%@", error);
                                           }];
    }
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
