//
//  NSString+Size.h
//  动态计算UITableViewCell高度详解
//
//  Created by apple on 15/6/17.
//  Copyright (c) 2015年 qisu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (LGSize)

/**
 *  @author lg, 16-04-12 13:04:36
 *
 *  @brief 计算字符串绘制区域大小
 *
 *  @param font          字体
 *  @param size          限制区域
 *  @param lineBreakMode 断行方式
 *
 *  @return 绘制区域大小
 */
- (CGSize)lg_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  @author lg, 16-04-12 13:04:36
 *
 *  @brief 计算字符串绘制区域大小(经过处理的值)(@""会有高度，nil高度为0)
 *
 *  @param font          字体
 *  @param size          限制区域
 *  @param lineBreakMode 断行方式
 *
 *  @return 绘制区域大小(经过处理的值)
 */
- (CGSize)lg_boundingCeilSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@interface NSAttributedString (LGSize)

/**
 *  @author lg, 16-04-12 13:04:36
 *
 *  @brief 计算字符串绘制区域大小
 *
 *  @param size          限制区域
 *
 *  @return 绘制区域大小
 */
- (CGSize)lg_boundingSizeWithConstrainedToSize:(CGSize)size;

/**
 *  @author lg, 16-04-12 13:04:36
 *
 *  @brief 计算字符串绘制区域大小(经过处理的值)(@""会有高度，nil高度为0)
 *
 *  @param size          限制区域
 *
 *  @return 绘制区域大小(经过处理的值)
 */
- (CGSize)lg_boundingCeilSizeWithConstrainedToSize:(CGSize)size;

@end


NS_ASSUME_NONNULL_END


