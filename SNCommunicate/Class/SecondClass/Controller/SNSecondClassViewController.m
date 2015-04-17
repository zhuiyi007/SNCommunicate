//
//  SNEntertainmentViewController.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNSecondClassViewController.h"
#import "SNThirdClassViewController.h"
#import "SNSecondClassCell.h"
#import "SNSecondCellData.h"


@interface SNSecondClassViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SNSecondClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createUI
{
    SNMainTableView *tableView = [[SNMainTableView alloc] initWithFrame:SNTableViewFrame
                                                                  style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSArray *)dataArray
{
    if(!_dataArray)
    {
        if (self.plist) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:self.plist ofType:@"plist"];
            NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in arrayDict) {
                SNSecondCellData *data = [SNSecondCellData dataWithDict:dict];
                [tempArray addObject:data];
            }
            _dataArray = tempArray;
        }
    }
    return _dataArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SNEntertainmentCell";
    SNSecondClassCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [SNSecondClassCell createCellWithIdentifier:identifier];
    }
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNThirdClassViewController *vc = [[SNThirdClassViewController alloc] init];
    vc.title = [self.dataArray[indexPath.row] title];
    vc.type = vc.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
