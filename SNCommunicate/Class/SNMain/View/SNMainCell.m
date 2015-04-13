//
//  SNMainCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNMainCell.h"

@implementation SNMainCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (SNMainCell *)createCellWithIdentifier:(NSString *)identify
{
    SNMainCell *cell = [[SNMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)setData:(SNMainCellData *)data
{
    self.imageView.image = [UIImage imageNamed:data.icon];
    self.textLabel.text = data.title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(13, 13, 30, 30);
    self.textLabel.x -= 20;
    self.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
}

@end
