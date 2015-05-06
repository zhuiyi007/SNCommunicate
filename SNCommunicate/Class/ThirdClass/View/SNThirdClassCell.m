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

// 级别view
@property (nonatomic, strong) UIView *levelView;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UIImageView *levelImage;

// 点赞view
@property (nonatomic, strong) UIView *commendView;
@property (nonatomic, strong) UILabel *commendCount;
@property (nonatomic, strong) UIImageView *commendImage;

// 访问量view
@property (nonatomic, strong) UIView *visitView;
@property (nonatomic, strong) UILabel *visitLable;
@property (nonatomic, strong) UILabel *visitCount;




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
        
        self.name = [[UILabel alloc] init];
        [self.name setFont:[UIFont systemFontOfSize:24.0]];
        [self.contentView addSubview:self.name];
        
        self.introduction = [[UILabel alloc] init];
        [self.contentView addSubview:self.introduction];
        
        self.address = [[UILabel alloc] init];
        [self.contentView addSubview:self.address];
        
        // 商家级别
        self.levelView = [[UIView alloc] init];
        [self.contentView addSubview:self.levelView];
        
        self.levelLabel = [[UILabel alloc] init];
        self.levelLabel.text = @"级别";
        self.levelLabel.textAlignment = NSTextAlignmentLeft;
        [self.levelLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.levelLabel setFrame:CGRectMake(0, 0, 35, 20)];
        [self.levelView addSubview:self.levelLabel];
        
        self.levelImage = [[UIImageView alloc] init];
        [self.levelImage setContentMode:UIViewContentModeScaleToFill];
        [self.levelImage setFrame:CGRectMake(35, 0, 25, 20)];
        [self.levelView addSubview:self.levelImage];
        
        // 点赞数量
        self.commendView = [[UIView alloc] init];
        [self.contentView addSubview:self.commendView];
        
        self.commendCount = [[UILabel alloc] init];
        self.commendCount.textAlignment = NSTextAlignmentLeft;
        [self.commendCount setFrame:CGRectMake(0, 0, 35, 20)];
        [self.commendView addSubview:self.commendCount];
        
        self.commendImage = [[UIImageView alloc] init];
        [self.commendImage setContentMode:UIViewContentModeScaleToFill];
        [self.commendImage setFrame:CGRectMake(35, 0, 25, 20)];
        [self.commendView addSubview:self.commendImage];
        
        // 访问量
        self.visitView = [[UIView alloc] init];
        [self.contentView addSubview:self.visitView];
        
        self.visitLable = [[UILabel alloc] init];
        self.visitLable.text = @"访问量";
        self.visitLable.textAlignment = NSTextAlignmentLeft;
        [self.visitLable setFont:[UIFont systemFontOfSize:12.0]];
        [self.visitLable setFrame:CGRectMake(0, 0, 50, 20)];
        [self.visitView addSubview:self.visitLable];
        
        self.visitCount = [[UILabel alloc] init];
        self.visitCount.textAlignment = NSTextAlignmentLeft;
        [self.visitCount setFrame:CGRectMake(50, 0, 10, 20)];
        [self.visitView addSubview:self.visitCount];
        
        
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
    self.name.text = data.Name;
    self.introduction.text = data.Introduction;
    self.address.text = data.Address;

    [self.levelImage setImage:[UIImage imageNamed:data.Level]];
    
    self.commendCount.text = data.Point;
    [self.commendImage setImage:[UIImage imageNamed:@"zan"]];
    
    self.visitCount.text = data.Visit;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    
    [self.image setFrame:CGRectMake(margin, (self.height - 80) * 0.5, 120, 80)];
    
    CGFloat rightViewW = 60;
    CGFloat rightViewH = 20;
    CGFloat rightViewX = SNScreenBounds.width - margin - rightViewW;
    CGFloat rightViewY = ( self.height - 3 * rightViewH - 2 * margin ) * 0.5;
    
    [self.levelView setFrame:CGRectMake(rightViewX, rightViewY, rightViewW, rightViewH)];
    
    [self.commendView setFrame:CGRectMake(rightViewX, CGRectGetMaxY(self.levelView.frame) + margin, rightViewW, rightViewH)];
    
    [self.visitView setFrame:CGRectMake(rightViewX, CGRectGetMaxY(self.commendView.frame) + margin, rightViewW, rightViewH)];
    
    CGFloat contentW = rightViewX - CGRectGetMaxX(self.image.frame) - 2 * margin;
    CGFloat contentH = 40;
    CGFloat contentX = CGRectGetMaxX(self.image.frame) + margin;
    CGFloat contentY = (self.height - contentH) * 0.5;
    [self.name setFrame:CGRectMake(contentX, contentY, contentW, contentH)];

    
    // 商店简介和地址暂时不要
//    [self.introduction setFrame:CGRectMake(contentX , CGRectGetMaxY(self.name.frame) + margin, contentW, contentH)];
//    
//    [self.address setFrame:CGRectMake(contentX, CGRectGetMaxY(self.introduction.frame) + margin, contentW, contentH)];
    
}

@end
