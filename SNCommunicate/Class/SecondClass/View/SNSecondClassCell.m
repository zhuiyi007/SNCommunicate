//
//  SNSecondClassCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNSecondClassCell.h"

@implementation SNSecondClassCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (SNSecondClassCell *)createCellWithIdentifier:(NSString *)identify
{
    SNSecondClassCell *cell = [[SNSecondClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = SNMainBackgroundColor;
    return cell;
}

- (void)setData:(SNSecondCellData *)data
{
    self.imageView.image = [UIImage imageNamed:data.icon];
    self.textLabel.text = data.title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(7, 7, 30, 30);
    self.textLabel.x -= 20;
    self.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
}

@end
