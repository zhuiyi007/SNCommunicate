//
//  UIImage+Tool.m
//  Lottery
//
//  Created by ZhuiYi on 14-11-9.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

+ (UIImage *)imageOriginalNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageResizableWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
