//
//  UIImageView+LG.m
//  AHCResidentClient
//
//  Created by 李刚 on 16/4/1.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "UIImageView+LG.h"

@implementation UIImageView (LG)

- (void)lg_addCorner:(CGFloat)radius {
    self.image = self.image ? [self lg_drawRectWithRoundedCornerWithRadius:radius sizeToFit:self.bounds.size] : nil;
}

- (UIImage *)lg_drawRectWithRoundedCornerWithRadius:(CGFloat)radius sizeToFit:(CGSize)sizeToFit {
    CGRect rect = CGRectMake(0, 0, sizeToFit.width, sizeToFit.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawRect:rect];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage * output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

- (void)lg_setImage:(UIImage *)image placeholderImage:(UIImage *)placeholder {
    if (image) {
        [self setImage:image];
    } else {
        [self setImage:placeholder];
    }
}
@end
