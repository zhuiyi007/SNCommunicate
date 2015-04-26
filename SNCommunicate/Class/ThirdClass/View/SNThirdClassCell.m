//
//  SNThirdClassCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNThirdClassCell.h"
@interface SNThirdClassCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *introduction;
@property (nonatomic, strong) UILabel *address;

// 点赞label
@property (nonatomic, strong) UILabel *commendView;
@property (nonatomic, strong) UIImageView *commendImage;



@end

@implementation SNThirdClassCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.image = [[UIImageView alloc] init];
        [self.image setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:self.image];
        
        self.commendView = [[UILabel alloc] init];
        self.commendView.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.commendView];
        
        self.commendImage = [[UIImageView alloc] init];
        [self.commendImage setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:self.commendImage];
        
        self.name = [[UILabel alloc] init];
        [self.contentView addSubview:self.name];
        
        self.introduction = [[UILabel alloc] init];
        [self.contentView addSubview:self.introduction];
        
        self.address = [[UILabel alloc] init];
        [self.contentView addSubview:self.address];
        
    }
    return self;
}

+ (SNThirdClassCell *)createCellWithIdentifier:(NSString *)identify
{
    SNThirdClassCell *cell = [[SNThirdClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.backgroundColor = SNMainBackgroundColor;
    return cell;
}

- (void)setData:(SNShopData *)data
{
    _data = data;
    NSURL *url = [NSURL URLWithString:data.picURL];
    [self.image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        SNLog(@"三级页面图片加载完毕");
    }];
    
    self.commendView.text = data.Point;
    [self.commendImage setImage:[UIImage imageNamed:@"zan"]];
    
    self.name.text = data.Name;
    self.introduction.text = data.Introduction;
    self.address.text = data.Address;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    
    [self.image setFrame:CGRectMake(margin, 25, 80, 80)];
    
    CGFloat commendH = 20;
    CGFloat commendImageX = SNScreenBounds.width - commendH - margin;
    CGFloat commendImageY = (self.height - commendH) / 2.0;
    [self.commendImage setFrame:CGRectMake(commendImageX, commendImageY, commendH, commendH)];
    
    [self.commendView sizeToFit];
    CGFloat commendViewW = self.commendView.height + 10;
    CGFloat commendViewX = commendImageX - commendViewW - margin;
    [self.commendView setFrame:CGRectMake(commendViewX, commendImageY, commendViewW, commendH)];
    
    CGFloat contentX = CGRectGetMaxX(self.image.frame) + margin;
    CGFloat contentW = commendViewX - CGRectGetMaxX(self.image.frame) - 2 * margin;
    CGFloat contentH = 20;
    [self.name setFrame:CGRectMake(contentX, margin, contentW, contentH)];
    
    [self.introduction setFrame:CGRectMake(contentX , CGRectGetMaxY(self.name.frame) + margin, contentW, contentH)];
    
    [self.address setFrame:CGRectMake(contentX, CGRectGetMaxY(self.introduction.frame) + margin, contentW, contentH)];
    
}

@end
