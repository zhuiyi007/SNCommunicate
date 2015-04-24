//
//  SNThirdClassNullCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/15.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNNullCell.h"

@implementation SNNullCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}


+ (SNNullCell *)createCellWithIdentifier:(NSString *)identify
{
    SNNullCell *cell = [[SNNullCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.backgroundColor = SNMainBackgroundColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.center = self.center;
}

@end
