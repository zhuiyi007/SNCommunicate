//
//  SNGuideCell.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/5/24.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNGuideCell.h"
@interface SNGuideCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end
@implementation SNGuideCell

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        [self addSubview:imageV];
        
        _imageView = imageV;
        
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
}
@end
