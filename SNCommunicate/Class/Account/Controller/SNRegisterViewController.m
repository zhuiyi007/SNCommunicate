//
//  SNRegisterViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/16.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNRegisterViewController.h"
#import "SNMainTextField.h"

@interface SNRegisterViewController ()
@property (weak, nonatomic) IBOutlet SNMainTextField *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet SNMainTextField *nameLabel;
@property (weak, nonatomic) IBOutlet SNMainTextField *passWordLabel;
@property (weak, nonatomic) IBOutlet SNMainTextField *securityCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityButton;

@property (nonatomic, strong) SNUserModel *userModel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger count;

@end

@implementation SNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.count = 10;
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getSecurityCodeButtonClick:(id)sender {
    [MBProgressHUD showMessage:@"请稍后"];
    [self.securityCodeLabel resignFirstResponder];
    [SNHttpTool getSMSSendWithPhoneNumber:self.phoneNumberLabel.text
                                   finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:responseObject[@"ret_msg"]];
            return;
        }
       [self addTimer];
        SNLog(@"%@", responseObject);
        SNLog(@"%@", responseObject[@"ret_msg"]);
                                   }
                                    error:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发送失败"];
        SNLog(@"%@", error);
                                    }];
}
- (IBAction)registerButtonClick:(id)sender {
    if (![self isDataLegal]) {
        return;
    }
    [MBProgressHUD showMessage:@"正在注册"];
    [SNHttpTool customerRegisterWithPhoneNumber:self.phoneNumberLabel.text
                                       passWord:self.passWordLabel.text
                                           name:self.nameLabel.text
                                   securityCode:self.securityCodeLabel.text
                                         finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
         SNLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue] == 0) {
            [MBProgressHUD showError:responseObject[@"ret_msg"]];
            return;
        }
        [MBProgressHUD showSuccess:@"注册成功"];
        self.userModel = [SNUserModel sharedInstance];
        self.userModel.phoneNumber = self.phoneNumberLabel.text;
        self.userModel.passWord = self.passWordLabel.text;
        self.userModel.name = self.nameLabel.text;
        [SNArchiverManger archiveWithUserModel:[SNUserModel sharedInstance]];
        [[NSNotificationCenter defaultCenter] postNotificationName:SNLoginSuccess object:nil];
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.navigationController popToRootViewControllerAnimated:YES];
         });
        
    }
                                          error:^(NSError *error) {
        [MBProgressHUD showError:@"注册失败"];
        SNLog(@"%@",error);
        
    }];
    
}

- (BOOL)isDataLegal
{
    if ([self.phoneNumberLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入手机号"];
        [self.phoneNumberLabel becomeFirstResponder];
        return NO;
    }
    if ([self.phoneNumberLabel.text length] != 11) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        [self.phoneNumberLabel becomeFirstResponder];
        return NO;
    }
    if ([self.nameLabel.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入姓名"];
        [self.nameLabel becomeFirstResponder];
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
        [self.getSecurityButton setEnabled:NO];
        [self.getSecurityButton setTitle:[NSString stringWithFormat:@"%zd(s)后重试", self.count] forState:UIControlStateDisabled];
        self.count --;
    }
    if (self.count == -1) {
        [self.getSecurityButton setEnabled:YES];
        [self removeTimer];
        self.count = 10;
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
