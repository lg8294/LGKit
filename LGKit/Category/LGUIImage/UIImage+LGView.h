//
//  UIImage+View.h
//  baiduMap
//
//  Created by 李刚 on 15/9/25.
//  Copyright © 2015年 李刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LGView)

///将UIView转成UIImage
+ (UIImage *)lg_imageFromView:(UIView *)view;

@end
