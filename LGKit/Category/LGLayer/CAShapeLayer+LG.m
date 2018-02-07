//
//  CAShapeLayer+CustomPath.m
//  AfterSchool
//
//  Created by lg on 16/1/4.
//  Copyright © 2016年 Teson Draw. All rights reserved.
//

#import "CAShapeLayer+LG.h"
#import "UIColor+LG.h"

NS_ASSUME_NONNULL_BEGIN
@implementation CAShapeLayer (LGPath)

+ (CGPathRef)lg_linePathWithRect:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, edgeInsets.left, rect.size.height - edgeInsets.bottom);
    CGPathAddLineToPoint(path, NULL, rect.size.width - edgeInsets.right, rect.size.height - edgeInsets.bottom);
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithCGPath:path];
    CGPathRelease(path);
    
    return bezierPath.CGPath;
}
+ (CGPathRef)lg_getLinePathWithSuperBounds:(CGRect)superBounds startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    UIBezierPath * linePath = [UIBezierPath bezierPathWithCGPath:path];
    CGPathRelease(path);
    
    return linePath.CGPath;
}

+ (CGPathRef)lg_arrowPathWithRect:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint start = CGPointMake(rect.size.width - edgeInsets.right - 7, rect.size.height/2 + 7);
    CGPoint mid = CGPointMake(rect.size.width - edgeInsets.right, rect.size.height/2);
    CGPoint end = CGPointMake(rect.size.width - edgeInsets.right - 7, rect.size.height/2 - 7);
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, mid.x, mid.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithCGPath:path];
    CGPathRelease(path);
    
    return bezierPath.CGPath;
}

+ (CAShapeLayer *)lg_getArrowLayer {
    CAShapeLayer * arrowLayer = [CAShapeLayer layer];
    [arrowLayer setLineWidth:3/[UIScreen mainScreen].scale];
    [arrowLayer setFillColor:[UIColor clearColor].CGColor];
    [arrowLayer setStrokeColor:lg_color(153, 1).CGColor];
    
    return arrowLayer;
}

+ (CAShapeLayer *)lg_getLineLayer {
    CAShapeLayer * lineLayer = [CAShapeLayer layer];
    [lineLayer setLineWidth:1/[UIScreen mainScreen].scale];
    [lineLayer setFillColor:[UIColor clearColor].CGColor];
    [lineLayer setStrokeColor:[UIColor lightGrayColor].CGColor];
    
    return lineLayer;
}
@end



NS_ASSUME_NONNULL_END


