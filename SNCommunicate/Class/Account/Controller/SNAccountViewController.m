//
//  SNAccountViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNAccountViewController.h"
#import "SNMainNavigationController.h"
#import "ZSTextField.h"
#import "SNTabBar.h"
#import "SNBase64.h"

@interface SNAccountViewController ()
@property (weak, nonatomic) IBOutlet ZSTextField *accountLabel;
@property (weak, nonatomic) IBOutlet ZSTextField *passWordLabel;

@property (nonatomic, strong) SNUserModel *userModel;

@end

@implementation SNAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];
    self.navigationItem.leftBarButtonItem = item;
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[SNTabBar tabBar] hiddenTabBar];
}

- (IBAction)loginButtonClick:(id)sender {
    if (![self isDataLegal]) {
        return;
    }
    NSString *passWord = [SNBase64 base64StringFromText:self.passWordLabel.text];
    [MBProgressHUD showMessage:@"登录中"];
    if ([self.accountLabel.text length] == 11) { // 顾客登录
        [SNHttpTool customerLoginWithPhoneNumber:self.accountLabel.text passWord:passWord finish:^(id responseObject) {
            [MBProgressHUD hideHUD];
            SNLog(@"%@", responseObject);
            if ([responseObject[@"status"] integerValue] == 0) {
                [MBProgressHUD showError:responseObject[@"ret_msg"]];
                return;
            }
            [MBProgressHUD showSuccess:@"登录成功"];
            self.userModel = [SNUserModel sharedInstance];
            self.userModel.phoneNumber = self.accountLabel.text;
            self.userModel.passWord = passWord;
            self.userModel.name = responseObject[@"ret_msg"];
            [SNArchiverManger archiveWithUserModel:[SNUserModel sharedInstance]];
            self.userModel.login = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:SNLoginSuccess object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } error:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"登录超时"];
            SNLog(@"%@", error);
        }];
    } else {
        [SNHttpTool businessLoginWithLoginNumber:self.accountLabel.text passWord:passWord finish:^(id responseObject) {
            [MBProgressHUD hideHUD];
            SNLog(@"%@", responseObject);
            if ([responseObject[@"status"] integerValue] == 0) {
                [MBProgressHUD showError:responseObject[@"ret_msg"]];
                return;
            }
            [MBProgressHUD showSuccess:@"登录成功"];
            self.userModel = [SNUserModel sharedInstance];
            self.userModel.phoneNumber = self.accountLabel.text;
            self.userModel.passWord = passWord;
            self.userModel.name = responseObject[@"Name"];
            [SNArchiverManger archiveWithUserModel:[SNUserModel sharedInstance]];
            self.userModel.login = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:SNLoginSuccess object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } error:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"登录超时"];
            SNLog(@"%@", error);
        }];
    }
    
}
- (IBAction)forgotPassWordButtonClick:(id)sender {
}

- (BOOL)isDataLegal
{
    if ([self.accountLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入手机号"];
        [self.accountLabel becomeFirstResponder];
        return NO;
    }
    if ([self.accountLabel.text length] != 11 && [self.accountLabel.text length] != 8) {
        [MBProgressHUD showError:@"请输入正确登录名"];
        [self.accountLabel becomeFirstResponder];
        return NO;
    }
    if ([self.passWordLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入密码"];
        [self.passWordLabel becomeFirstResponder];
        return NO;
    }
    if ([self.passWordLabel.text length] <= 4) {
        [MBProgressHUD showError:@"密码必须大于4位"];
        [self.passWordLabel becomeFirstResponder];
        return NO;
    }
    
    return YES;
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
