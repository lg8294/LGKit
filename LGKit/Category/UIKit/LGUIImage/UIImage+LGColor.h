//
//  UIImage+Color.h
//  AfterSchool
//
//  Created by lg on 16/1/9.
//  Copyright © 2016年 Teson Draw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LGColor)

/**
 生成指定大小指定颜色的图片
 
 @param color 颜色
 @param size 大小
 @return 图片
 */
+ (UIImage*)lg_imageWithColor:(UIColor*)color size:(CGSize)size;

/**
 生成指定颜色的 image

 @param color 颜色
 @return 图片
 */
+ (UIImage*)lg_imageWithColor:(UIColor*)color;

@end
