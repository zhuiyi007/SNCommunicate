//
//  SNBusinessOrderViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/9.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNBusinessOrderViewController.h"

@interface SNBusinessOrderViewController ()

@property (nonatomic, strong) SNUserModel *userModel;

@end

@implementation SNBusinessOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:SNMainBackgroundColor];
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

- (void)setData
{
    [SNHttpTool selectDingDanByLoginNum:self.userModel.phoneNumber passWord:self.userModel.passWord big:0 small:0 finish:^(id responseObject) {
        
    } error:^(NSError *error) {
        
    }];
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
