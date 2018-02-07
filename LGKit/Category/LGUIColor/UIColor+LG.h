//
//  UIColor+RandomColor.h
//  qisuedu
//
//  Created by apple on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

// 颜色
#define lg_color(c,alp) [UIColor colorWithRed:(c)/255.0 \
                                        green:(c)/255.0 \
                                         blue:(c)/255.0 \
                                        alpha:alp]

#define lg_colorRGB(r,g,b,alp) [UIColor colorWithRed:(r)/255.0 \
                                               green:(g)/255.0 \
                                                blue:(b)/255.0 \
                                               alpha:alp]

#define lg_colorFromRGB(hexRGB) [UIColor colorWithRed:((hexRGB&0xff0000)>>16)/255.0 \
                                                green:((hexRGB&0xff00)>>8)/255.0 \
                                                 blue:(hexRGB&0xff)/255.0 \
                                                alpha:1]

#define lg_colorFromRGBA(hexRGB,alp) [UIColor colorWithRed:((hexRGB&0xFF0000)>>16)/255.0 \
                                                     green:((hexRGB&0xFF00)>>8)/255.0 \
                                                      blue:(hexRGB&0xFF)/255.0 \
                                                     alpha:(float)(alp)]


@interface UIColor (LG)

/**
 *  @author lg, 16-03-22 20:03:41
 *
 *  @brief 获取随机色（R = G = B）
 *
 *  @return 随机色
 */
+ (UIColor *)lg_randomColor;

/**
 *  @author lg, 16-03-22 20:03:25
 *
 *  @brief 获取随机色 （R,G,B都随机）
 *
 *  @return 随机色
 */
+ (UIColor *)lg_randomColorOne;

/**
 *  @brief  通过10进制RGB设定颜色
 *
 *  @param decColor 10进制RGB颜色（000123444）
 *
 *  @return 颜色
 */
+ (UIColor *)lg_getColorDec:(NSString *)decColor;

/**
 获取UIColor对象的rgb值。

 @param originColor 颜色对象
 @return  hex字符串
 */
+ (NSString *)lg_getHexStringByColor:(UIColor *)originColor;

+ (UIColor *)lg_DarkColor;
+ (UIColor *)lg_LightColor;

@end
