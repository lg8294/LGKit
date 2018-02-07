//
//  UIColor+RandomColor.m
//  qisuedu
//
//  Created by apple on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIColor+LG.h"

@implementation UIColor (LG)

+ (UIColor *)lg_randomColor
{
    CGFloat random = arc4random()%255 / 255.0;
    
    UIColor * randomColor = [UIColor colorWithRed:random green:random blue:random alpha:1];
    
    //NSLog(@"%@", randomColor);
    
    return randomColor;
}

+ (UIColor *)lg_randomColorOne
{
    CGFloat redRandom = arc4random()%255 / 255.0;
    CGFloat greenRandom = arc4random()%255 / 255.0;
    CGFloat blueRandom = arc4random()%255 / 255.0;
    
    UIColor * randomColor = [UIColor colorWithRed:redRandom green:greenRandom blue:blueRandom alpha:1];
    
    return randomColor;
}

+ (UIColor *)lg_getColorDec:(NSString *)decColor
{
    NSInteger red,green,blue;
    NSRange range;
    range.length = 3;
    
    range.location = 0;
    [[NSScanner scannerWithString:[decColor substringWithRange:range]] scanInteger:&red];
    
    range.location = 3;
    [[NSScanner scannerWithString:[decColor substringWithRange:range]] scanInteger:&green];
    
    range.location = 6;
    [[NSScanner scannerWithString:[decColor substringWithRange:range]] scanInteger:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

+ (NSString *)lg_getHexStringByColor:(UIColor *)originColor
{
    NSDictionary *colorDic
    = [self lg_getRGBDictionaryByColor:originColor];
    int r = [colorDic[@"R"] floatValue] * 255;
    int g = [colorDic[@"G"] floatValue] * 255;
    int b = [colorDic[@"B"] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
    
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}

+ (NSDictionary *)lg_getRGBDictionaryByColor:(UIColor *)originColor
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}

+ (UIColor *)lg_DarkColor {
    return lg_colorFromRGBA(0x999999, 1);
}

+ (UIColor *)lg_LightColor {
    return [UIColor groupTableViewBackgroundColor];
}
@end
