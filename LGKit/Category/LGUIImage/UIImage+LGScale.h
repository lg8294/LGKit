//
//  UIImage+RCImage.h
//  RCloudMessage
//
//  Created by Liv on 15/4/7.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LGScale)

/**
 *  @brief 修改图片size
 *
 *  @param image 原图片
 *  @param size  要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)lg_imageScaleWithOriginImage:(UIImage *)image toSize:(CGSize)size;

/**
 *  @brief 修改图片size
 *
 *  @param size 修改的size
 *
 *  @return 修改后的图片
 */
- (UIImage *)lg_imageScaleToSize:(CGSize)size;
@end
