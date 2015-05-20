//
//  SNBusinessStroeCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/10.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNBusinessStroeCell.h"

@interface SNBusinessStroeCell()<UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView *Pic;
@property (nonatomic, strong) UILabel *Name;
@property (nonatomic, strong) UILabel *store;
@property (nonatomic, strong) UIButton *change;
@property (nonatomic, strong) SNUserModel *userModel;
@end

@implementation SNBusinessStroeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (SNUserModel *)userModel
{
    if (!_userModel) {
        _userModel = [SNUserModel sharedInstance];
    }
    return _userModel;
}

+ (SNBusinessStroeCell *)createCellWithIdentifier:(NSString *)identify
{
    SNBusinessStroeCell *cell = [[SNBusinessStroeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.backgroundColor = SNMainBackgroundColor;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.Pic = [[UIImageView alloc] init];
        [self.Pic setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:self.Pic];
        
        self.Name = [[UILabel alloc] init];
        self.Name.numberOfLines = 0;
        [self.contentView addSubview:self.Name];
        
        self.store = [[UILabel alloc] init];
        [self.contentView addSubview:self.store];
        
        self.change = [[UIButton alloc] init];
        [self.change addTarget:self action:@selector(changeStoreNumber) forControlEvents:UIControlEventTouchUpInside];
        [self.change setTitle:@"修改" forState:UIControlStateNormal];
        [self.change setBackgroundColor:SNMainGreenColor];
        [self.change setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
        [self.contentView addSubview:self.change];
    }
    return self;
}

- (void)setDetailsData:(SNDetailsData *)detailsData
{
    _detailsData = detailsData;
    NSURL *url = [NSURL URLWithString:detailsData.Pic];
    [self.Pic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    self.Name.text = [NSString stringWithFormat:@"商　品:%@", detailsData.Name];
    
    self.store.text = [NSString stringWithFormat:@"库存量:%@", detailsData.Store];
}

- (void)changeStoreNumber
{
    SNLog(@"%@", self.detailsData.Store);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改库存数量" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.text = self.detailsData.Store;
    [alert show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *textFiled = [alertView textFieldAtIndex:0];
        if (!textFiled.text) {
            textFiled.text = @"0";
        }
        self.detailsData.Store = textFiled.text;
        [MBProgressHUD showMessage:@"正在修改"];
        [SNHttpTool changeStoreWithLoginNum:self.userModel.phoneNumber passWord:self.userModel.passWord store:[self.detailsData.Store integerValue] productID:[self.detailsData.ID integerValue] finish:^(id responseObject) {
            SNLog(@"%@", responseObject);
            [MBProgressHUD hideHUD];
            if ([responseObject[@"status"] integerValue] == 0) {
                [MBProgressHUD showError:responseObject[@"ret_msg"]];
                return;
            }
            [MBProgressHUD showSuccess:responseObject[@"ret_msg"]];
            self.store.text = [NSString stringWithFormat:@"库存量:%@", self.detailsData.Store];
            [self.store sizeToFit];
        } error:^(NSError *error) {
            SNLog(@"%@", error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"修改失败"];
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    [self.Pic setFrame:CGRectMake(margin, (self.height - 80) * 0.5, 120, 80)];
    
    self.Name.width = self.width - CGRectGetMaxX(self.Pic.frame) - 2 * margin;
    [self.Name sizeToFit];
    [self.store sizeToFit];
    CGFloat labelY = (self.height - self.Name.height - self.store.height - margin) * 0.5;
    [self.Name setFrame:CGRectMake(CGRectGetMaxX(self.Pic.frame) + margin, labelY, self.Name.width, self.Name.height)];
    
    [self.store setFrame:CGRectMake(CGRectGetMaxX(self.Pic.frame) + margin, CGRectGetMaxY(self.Name.frame) + margin, self.store.width, self.store.height)];
    
    [self.change setFrame:CGRectMake(SNScreenBounds.width - margin - 80, self.height - margin - 30, 80, 30)];
}

@end
