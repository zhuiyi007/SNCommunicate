//
//  SNRegisterViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/16.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNRegisterViewController.h"

@interface SNRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeLabel;

@end

@implementation SNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getSecurityCodeButtonClick:(id)sender {
    [SNHttpTool getSMSSendWithPhoneNumber:self.phoneNumberLabel.text andIPAddress:@"127.0.0.1" finish:^(id responseObject) {
        SNLog(@"%@", responseObject);
    } error:^(NSError *error) {
        SNLog(@"%@", error);
    }];
}
- (IBAction)registerButtonClick:(id)sender {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumberLabel resignFirstResponder];
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
