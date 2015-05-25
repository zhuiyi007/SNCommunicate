//
//  SNForgetPassWordViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/24.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNForgetPassWordViewController.h"
#import "SNMainTextField.h"
#import "SNBase64.h"

@interface SNForgetPassWordViewController ()
@property (weak, nonatomic) IBOutlet SNMainTextField *phoneNumber;
@property (weak, nonatomic) IBOutlet SNMainTextField *changePassWord;
@property (weak, nonatomic) IBOutlet SNMainTextField *currentPassWord;
@property (weak, nonatomic) IBOutlet SNMainTextField *securityCode;
@property (weak, nonatomic) IBOutlet SNMainTextField *loginNumber;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeButton;
@property (nonatomic, strong) SNUserModel *userModel;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SNForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:SNMainBackgroundColor];
    self.title = @"忘记密码";
    self.count = 60;
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
- (IBAction)getSecurityCodeButtonClick {
    [MBProgressHUD showMessage:@"请稍后"];
    [self.phoneNumber resignFirstResponder];
    [SNHttpTool getSMSSendWithPhoneNumber:self.phoneNumber.text finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] integerValue] == 0) {
            [MBProgressHUD showError:responseObject[@"ret_msg"]];
            return;
        }
        [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
        [self addTimer];
        SNLog(@"%@", responseObject);
        SNLog(@"%@", responseObject[@"ret_msg"]);
    } error:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发送失败"];
        SNLog(@"%@", error);
    }];
}
- (IBAction)changePassWordButtonClick {
    if (![self isDataLegal]) {
        return;
    }
    [MBProgressHUD showMessage:@"请稍后"];
    NSString *passWord = [SNBase64 base64StringFromText:self.changePassWord.text];
    if ([self.loginNumber.text isEqualToString:@""]) { // 顾客修改密码
        [SNHttpTool changePWDByVCWithPhoneNumber:self.phoneNumber.text newPassWord:passWord securityCode:self.securityCode.text finish:^(id responseObject) {
            SNLog(@"%@", responseObject);
            [MBProgressHUD hideHUD];
            if ([responseObject[@"status"] integerValue] == 0) {
                [MBProgressHUD showError:responseObject[@"ret_msg"]];
                return;
            }
            [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
            self.userModel.phoneNumber = self.phoneNumber.text;
            self.userModel.passWord = passWord;
            self.userModel.login = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        } error:^(NSError *error) {
            SNLog(@"%@", error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"修改失败"];
        }];
    } else { //商家修改密码
        [SNHttpTool businessChangePWDByVCWithLoginNumber:self.loginNumber.text securityCode:self.securityCode.text newPassWord:passWord phoneNumber:self.phoneNumber.text finish:^(id responseObject) {
            SNLog(@"%@", responseObject);
            [MBProgressHUD hideHUD];
            if ([responseObject[@"status"] integerValue] == 0) {
                [MBProgressHUD showError:responseObject[@"ret_msg"]];
                return;
            }
            [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
            self.userModel.phoneNumber = self.phoneNumber.text;
            self.userModel.passWord = passWord;
            self.userModel.login = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        } error:^(NSError *error) {
            SNLog(@"%@", error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"修改失败"];
        }];
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
    if ([self.phoneNumber.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入手机号"];
        [self.phoneNumber becomeFirstResponder];
        return NO;
    }
    if ([self.phoneNumber.text length] != 11) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        [self.phoneNumber becomeFirstResponder];
        return NO;
    }
    if ([self.changePassWord.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入新密码"];
        [self.changePassWord becomeFirstResponder];
        return NO;
    }
    if ([self.currentPassWord.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入确认密码"];
        [self.currentPassWord becomeFirstResponder];
        return NO;
    }
    if ([self.changePassWord.text length] <= 4) {
        [MBProgressHUD showError:@"密码必须大于4位"];
        [self.changePassWord becomeFirstResponder];
        return NO;
    }
    if ([self.currentPassWord.text length] <= 4) {
        [MBProgressHUD showError:@"密码必须大于4位"];
        [self.currentPassWord becomeFirstResponder];
        return NO;
    }
    if (![self.changePassWord.text isEqualToString:self.currentPassWord.text]) {
        [MBProgressHUD showError:@"两次输入的密码不同"];
        [self.currentPassWord becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)addTimer
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateButton) userInfo:nil repeats:YES];
    }
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateButton
{
    if (self.count >= 0) {
        [self.getSecurityCodeButton setEnabled:NO];
        self.getSecurityCodeButton.titleLabel.text = [NSString stringWithFormat:@"%zd(s)后重试", self.count];
        [self.getSecurityCodeButton setTitle:[NSString stringWithFormat:@"%zd(s)后重试", self.count] forState:UIControlStateDisabled];
        self.count --;
    }
    if (self.count == -1) {
        [self.getSecurityCodeButton setEnabled:YES];
        [self removeTimer];
        self.count = 60;
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
