//
//  UIView+AutoLayout.m
//  AutoLayout
//
//  Created by rimi on 15/1/9.
//  Copyright (c) 2015年 rimi. All rights reserved.
//

#import "UIView+LGAutoLayout.h"

@implementation UIView (LGAutoLayout)

/**
 *  LG位置约束
 *
 *  @param left    到左边距离
 *  @param right   到右边距离
 *  @param top     到上边距离
 *  @param bottom  到底部距离
 *  @param view    约束对象
 *  @param metrice nil
 */
- (void)lg_autoLayoutWithSubViewWithLeft:(CGFloat)left
                                   right:(CGFloat)right
                                     top:(CGFloat)top
                                  bottom:(CGFloat)bottom
                                    view:(UIView *)view
                                  metric:(NSDictionary *)metric
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[view]-%f-|",left,right] options:NSLayoutFormatDirectionLeadingToTrailing metrics:metric views:@{@"view":view}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[view]-%f-|",top,bottom] options:NSLayoutFormatDirectionLeadingToTrailing metrics:metric views:@{@"view":view}]];
}
/**
 *  比例约束
 *
 *  @param view             约束对象
 *  @param multiplierX      centerX 比例系数
 *  @param constantX        centerX 偏移距离
 *  @param multiplierY      centerY 比例系数
 *  @param constantY        centerY 偏移距离
 *  @param multiplierWidth  width 比例系数
 *  @param constantWidth    width 偏移距离
 *  @param multiplierHeight height 比例系数
 *  @param constantHeight   height 偏移距离
 */
- (void)lg_autoLayoutAddSubView:(UIView *)view
                     multiplierX:(CGFloat)multiplierX
                       constantX:(CGFloat)constantX
                     multiplierY:(CGFloat)multiplierY
                       constantY:(CGFloat)constantY
                 multiplierWidth:(CGFloat)multiplierWidth
                   constantWidth:(CGFloat)constantWidth
                multiplierHeight:(CGFloat)multiplierHeight
                  constantHeight:(CGFloat)constantHeight
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:multiplierX constant:constantX]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:multiplierY constant:constantY]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:multiplierWidth constant:constantWidth]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:multiplierHeight constant:constantHeight]];
}


/**
 *  约束宽度（相对于其他试图）
 *
 *  @param view       约束对象
 *  @param multiolier 比例系数
 *  @param constant   偏移量
 */
- (void)lg_autoLayoutWidthwithSubView:(UIView *)view mutiolierWidth:(CGFloat)multiolier constantWidth:(CGFloat)constant
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:multiolier constant:constant]];
}

/**
 *  约束高度（相对于其他视图）
 *
 *  @param view       约束对象
 *  @param multiolier 比例系数
 *  @param constant   偏移量
 */
- (void)lg_autoLayoutHeightwithSubView:(UIView *)view mutiolierHeight:(CGFloat)multiolier constantHeight:(CGFloat)constant
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:multiolier constant:constant]];
}

/**
 *  约束宽高比（相对于自身）
 *
 *  @param multiolier 宽高比
 *  @param constant   偏移量
 */
- (void)lg_autoLayoutAspactRatioWithMultiolier:(CGFloat)multiolier constant:(CGFloat)constant
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:multiolier constant:constant]];
}

/**
 *  约束中心（相对于其他视图）
 *
 *  @param view        约束对象
 *  @param multiolierX x比例系数
 *  @param constantX   x偏移量
 *  @param multiolierY y比例系数
 *  @param constantY   y偏移量
 */
- (void)lg_autoLayoutCenterWithSubView:(UIView *)view multiolierX:(CGFloat)multiolierX constantX:(CGFloat)constantX multiolierY:(CGFloat)multiolierY constantY:(CGFloat)constantY
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:multiolierX constant:constantX]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:multiolierY constant:constantY]];
}

@end
