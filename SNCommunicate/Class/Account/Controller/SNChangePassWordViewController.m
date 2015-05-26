//
//  SNChangePassWordViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/26.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNChangePassWordViewController.h"
#import "SNMainTextField.h"
#import "SNBase64.h"

@interface SNChangePassWordViewController ()
@property (weak, nonatomic) IBOutlet SNMainTextField *accountLabel;
@property (weak, nonatomic) IBOutlet SNMainTextField *oldPassWordLabel;
@property (weak, nonatomic) IBOutlet SNMainTextField *passWordLabel;
@property (weak, nonatomic) IBOutlet SNMainTextField *confirmPassWordLabel;

@property (nonatomic, strong) SNUserModel *userModel;

@end

@implementation SNChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self.view setBackgroundColor:SNMainBackgroundColor];
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
- (IBAction)changePassWordButtonClick {
    if ([self isDataLegal]) {
        NSString *oldPassWord = [SNBase64 base64StringFromText:self.oldPassWordLabel.text];
        NSString *newPassWord = [SNBase64 base64StringFromText:self.passWordLabel.text];
        [MBProgressHUD showMessage:@"请稍后"];
        if (self.accountLabel.text.length == 11) { // 顾客身份
            [SNHttpTool changePWDByPWDWithPhoneNumber:self.accountLabel.text oldPassWord:oldPassWord newPassWord:newPassWord finish:^(id responseObject) {
                SNLog(@"%@", responseObject);
                [MBProgressHUD hideHUD];
                if ([responseObject[@"status"] integerValue] == 0) {
                    [MBProgressHUD showError:responseObject[@"ret_msg"]];
                    return;
                }
                [MBProgressHUD showSuccess:@"修改成功"];
                self.userModel.phoneNumber = self.accountLabel.text;
                self.userModel.passWord = newPassWord;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self login];
                });
            } error:^(NSError *error) {
                SNLog(@"%@", error);
                [MBProgressHUD showError:@"修改失败"];
            }];
        } else { // 商家身份
            [SNHttpTool businessChangePWDByPWDWithLoginNumber:self.accountLabel.text oldPassWord:oldPassWord newPassWord:newPassWord finish:^(id responseObject) {
                SNLog(@"%@", responseObject);
                [MBProgressHUD hideHUD];
                if ([responseObject[@"status"] integerValue] == 0) {
                    [MBProgressHUD showError:responseObject[@"ret_msg"]];
                    return;
                }
                [MBProgressHUD showSuccess:@"修改成功"];
                self.userModel.phoneNumber = self.accountLabel.text;
                self.userModel.passWord = newPassWord;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self login];
                });
            } error:^(NSError *error) {
                SNLog(@"%@", error);
                [MBProgressHUD showError:@"修改失败"];
            }];
        }
    }
}

- (void)login
{
    [MBProgressHUD showMessage:@"请稍后"];
    if ([self.userModel.phoneNumber length] == 11) {
        [SNHttpTool customerLoginWithPhoneNumber:self.userModel.phoneNumber passWord:self.userModel.passWord finish:^(id responseObject) {
            [MBProgressHUD hideHUD];
            SNLog(@"%@", responseObject);
            if ([responseObject[@"status"] integerValue] == 0) {
                // 验证不通过,删除本地缓存
                [[NSFileManager defaultManager] removeItemAtPath:SNUserInfoPath error:nil];
                [MBProgressHUD showError:@"登录失败"];
                return;
            }
            self.userModel.login = YES;
            self.userModel.name = responseObject[@"ret_msg"];
            [SNArchiverManger archiveWithUserModel:self.userModel];
            [[NSNotificationCenter defaultCenter] postNotificationName:SNLoginSuccess object:self];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } error:^(NSError *error) {
            SNLog(@"%@", error);
            [MBProgressHUD showError:@"登录失败"];
        }];
    } else {
        [SNHttpTool businessLoginWithLoginNumber:self.userModel.phoneNumber passWord:self.userModel.passWord finish:^(id responseObject) {
            [MBProgressHUD hideHUD];
            SNLog(@"%@", responseObject);
            if ([responseObject[@"status"] integerValue] == 0) {
                // 验证不通过,删除本地缓存
                [[NSFileManager defaultManager] removeItemAtPath:SNUserInfoPath error:nil];
                [MBProgressHUD showError:@"登录失败"];
                return;
            }
            self.userModel.login = YES;
            self.userModel.name = responseObject[@"Name"];
            [SNArchiverManger archiveWithUserModel:self.userModel];
            [[NSNotificationCenter defaultCenter] postNotificationName:SNLoginSuccess object:self];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } error:^(NSError *error) {
            SNLog(@"%@", error);
            [MBProgressHUD showError:@"登录失败"];
        }];
    }
}


- (BOOL)isDataLegal
{
    if ([self.accountLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入账号"];
        [self.accountLabel becomeFirstResponder];
        return NO;
    }
    if ([self.accountLabel.text length] != 11 && [self.accountLabel.text length] != 8) {
        [MBProgressHUD showError:@"请输入正确账号"];
        [self.accountLabel becomeFirstResponder];
        return NO;
    }
    if ([self.oldPassWordLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入旧密码"];
        [self.oldPassWordLabel becomeFirstResponder];
        return NO;
    }
    if ([self.passWordLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入新密码"];
        [self.passWordLabel becomeFirstResponder];
        return NO;
    }
    if ([self.confirmPassWordLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入确认密码"];
        [self.confirmPassWordLabel becomeFirstResponder];
        return NO;
    }
    if ([self.oldPassWordLabel.text length] <= 4) {
        [MBProgressHUD showError:@"密码必须大于4位"];
        [self.oldPassWordLabel becomeFirstResponder];
        return NO;
    }
    if ([self.passWordLabel.text length] <= 4) {
        [MBProgressHUD showError:@"密码必须大于4位"];
        [self.passWordLabel becomeFirstResponder];
        return NO;
    }
    if ([self.passWordLabel.text isEqualToString:self.oldPassWordLabel.text]) {
        [MBProgressHUD showError:@"新旧密码不能相同"];
        [self.passWordLabel becomeFirstResponder];
        return NO;
    }
    if (![self.passWordLabel.text isEqualToString:self.confirmPassWordLabel.text]) {
        [MBProgressHUD showError:@"两次输入的密码不同"];
        [self.confirmPassWordLabel becomeFirstResponder];
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
