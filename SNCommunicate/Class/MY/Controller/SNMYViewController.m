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

@end

@implementation SNMYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    if (![SNUserModel sharedInstance].phoneNumber) {
        UIStoryboard *accountStoryBoard = [UIStoryboard storyboardWithName:@"SNAccountViewController" bundle:nil];
        SNAccountViewController *account = [accountStoryBoard instantiateInitialViewController];
        [self.navigationController pushViewController:account animated:YES];
        if ([self.delegate respondsToSelector:@selector(myViewControllerHiddenTabBar:)]) {
            [self.delegate myViewControllerHiddenTabBar:self];
        }
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
