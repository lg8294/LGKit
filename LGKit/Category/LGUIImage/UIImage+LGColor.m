//
//  UIImage+Color.m
//  AfterSchool
//
//  Created by lg on 16/1/9.
//  Copyright © 2016年 Teson Draw. All rights reserved.
//

#import "UIImage+LGColor.h"

@implementation UIImage (LGColor)

+ (UIImage *)lg_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    float scale = [UIScreen mainScreen].scale;
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)lg_imageWithColor:(UIColor*) color
{
    return [self lg_imageWithColor:color size:CGSizeMake(1, 1)];
}



@end
