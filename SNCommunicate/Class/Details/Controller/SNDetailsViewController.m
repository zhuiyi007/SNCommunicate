//
//  SNDetailsViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/18.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNDetailsViewController.h"
#import "SNDetailsData.h"
#import "SNDetailsModel.h"
#import "SNDetailsScrollView.h"

@interface SNDetailsViewController ()

@property (nonatomic, strong) SNDetailsScrollView *scrollView;
@property (nonatomic, strong)  SNDetailsModel *detailsModel;


@end

@implementation SNDetailsViewController

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

- (void)createUI
{
    SNDetailsScrollView *scrollView = [[SNDetailsScrollView alloc] init];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    // 预定收藏
    [self reserveView];
}

- (void)createNilUI
{
    UILabel *nilLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SNScreenBounds.width, 44)];
    nilLabel.text = self.detailsModel.ret_msg;
    nilLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nilLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SNScreenBounds.width, 1)];
    [lineView setBackgroundColor:[UIColor blackColor]];
    [nilLabel addSubview:lineView];
    
}

- (void)reserveView
{
    CGFloat height = 49;
    UIView *reserveView = [[UIView alloc] initWithFrame:CGRectMake(0, SNScreenBounds.height - 49, SNScreenBounds.width, height)];
    [reserveView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:reserveView];
    
    UIButton *reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reserveButton setFrame:CGRectMake(0, 0, reserveView.width * 0.5, height)];
    [reserveButton setBackgroundColor:SNColor(30, 47, 55)];
    [reserveButton setTitle:@"预定" forState:UIControlStateNormal];
    [reserveButton setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
    [reserveButton.layer setMasksToBounds:YES];
    [reserveButton.layer setBorderWidth:2.0]; //边框宽度
    [reserveButton.layer setBorderColor:SNCGColor(119, 119, 119)]; //边框颜色
    [reserveView addSubview:reserveButton];
    
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionButton setFrame:CGRectMake(reserveView.width * 0.5, 0, reserveView.width * 0.5, height)];
    [collectionButton setBackgroundColor:SNColor(30, 47, 55)];
    [collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectionButton setTitleColor:SNMainBackgroundColor forState:UIControlStateNormal];
    [collectionButton.layer setMasksToBounds:YES];
    [collectionButton.layer setBorderWidth:2.0]; //边框宽度
    [collectionButton.layer setBorderColor:SNCGColor(119, 119, 119)];//边框颜色
    [reserveView addSubview:collectionButton];
}

- (void)setData
{
    [MBProgressHUD showMessage:@"正在加载"];
    [SNHttpTool getShangInfoNoIdentityWithShangID:self.shopData.ID
                                          andType:self.shopData.Type
                                              Big:0
                                            Small:0
                                           finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
        SNLog(@"%@",responseObject);
        self.detailsModel = [SNDetailsModel objectWithKeyValues:responseObject];
        if (self.detailsModel.ret_msg) {
            [self createNilUI];
            return;
        }
        [self createUI];
        self.scrollView.dataArray = self.detailsModel.result;
        self.scrollView.shopData = self.shopData;
                                           } error:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败"];
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
