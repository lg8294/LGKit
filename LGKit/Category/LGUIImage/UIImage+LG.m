//
//  UIImage+LG.m
//  AHCResidentClient
//
//  Created by 李刚 on 16/4/1.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "UIImage+LG.h"

@implementation UIImage (LG)

//+ (UIImage *)lg_drawRectWithView:(UIView *)view radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
//    
////    float scale = [UIScreen mainScreen].scale;
////    CGRect rect=CGRectMake(0, 0, size.width, size.height);
////    
////    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    CGContextSetFillColorWithColor(context, [color CGColor]);
////    CGContextFillRect(context, rect);
////    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
//    
//    
//    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
////    CGContextMoveToPoint(context, 0, 0);  // 开始坐标右边开始
////    CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
////    CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
////    CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
////    CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
//    
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);
//    UIImage * output = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return output;
//}

@end
