//
//  UIView+UINib.m
//  qisuedu
//
//  Created by lg on 15/8/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIView+LG.h"

@implementation UIView (LG)
+ (instancetype)lg_viewFromNibWithoutOwner
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return views[0];
}

//- (UIImage *)lg_drawRectWithRoundedCornerWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
//    UIGraphicsBeginImageContextWithOptions([self sizeToFit], false, [UIScreen mainScreen].scale)
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextMoveToPoint(context, 开始位置);  // 开始坐标右边开始
//    CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
//    
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
//    UIImage * output = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return output;
//}
//
//- (void)lg_addCornerWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
//    UIImageView * imageView = [[UIImageView alloc] initWithImage:[self lg_drawRectWithRoundedCornerWithRadius:radius borderWidth:borderWidth backgroundColor:backgroundColor borderColor:borderColor]];
//    [self insertSubview:imageView atIndex:0];
//}
//
//
//func kt_drawRectWithRoundedCorner(radius radius: CGFloat,
//                                  borderWidth: CGFloat,
//                                  backgroundColor: UIColor,
//                                  borderColor: UIColor) -> UIImage {
//    UIGraphicsBeginImageContextWithOptions(sizeToFit, false, UIScreen.mainScreen().scale)
//    let context = UIGraphicsGetCurrentContext()
//    
//    CGContextMoveToPoint(context, 开始位置);  // 开始坐标右边开始
//    CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
//    
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
//    let output = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return output
//}


@end
