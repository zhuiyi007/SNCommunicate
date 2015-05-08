//
//  UIViewController+YCCommon.m
//  iWeidao
//
//  Created by yongche on 13-11-8.
//  Copyright (c) 2013年 Weidao. All rights reserved.
//

#import "UIViewController+SNCommon.h"
#import "SNProgressHUD.h"

//#import "MobClick.h"

@interface UIViewController()

@property (nonatomic,strong)MBProgressHUD * hub;

@end

@implementation UIViewController (SNCommon)
@dynamic homeShotImageV;


- (void)showProgressHUD
{
    [self hideProgressHUD];
    [SNProgressHUD showHUDAddedTo:self.view];
}
- (void)hideProgressHUD
{
    [SNProgressHUD hideHUDForView:self.view];
}

- (void)showToastMessage:(NSString *)message
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end



