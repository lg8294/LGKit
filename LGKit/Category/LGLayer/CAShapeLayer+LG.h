//
//  CAShapeLayer+CustomPath.h
//  AfterSchool
//
//  Created by lg on 16/1/4.
//  Copyright © 2016年 Teson Draw. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayer (LGPath)

/**
 *  @brief 创建横线路径
 *
 *  @param rect       父视图bounds
 *  @param edgeInsets 相对父视图偏移（上偏移无效）
 *
 *  @return 横线路径
 */
+ (CGPathRef)lg_linePathWithRect:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets;

/**
 *  @brief 创建线
 *
 *  @param superBounds 线的父视图
 *  @param startPoint  线在父视图上的起始点
 *  @param endPoint    线在父视图上的终止点
 *
 *  @return 线的路径
 */
+ (CGPathRef)lg_getLinePathWithSuperBounds:(CGRect)superBounds startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 *  @brief 创建箭头路径
 *
 *  @param rect       父视图bounds
 *  @param edgeInsets 相对父视图偏移（只有右偏移有效）
 *
 *  @return 箭头路径
 */
+ (CGPathRef)lg_arrowPathWithRect:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets;

+ (CAShapeLayer *)lg_getArrowLayer;
+ (CAShapeLayer *)lg_getLineLayer;

@end
