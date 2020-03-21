//
//  UIImage+View.m
//  baiduMap
//
//  Created by 李刚 on 15/9/25.
//  Copyright © 2015年 李刚. All rights reserved.
//

#import "UIImage+LGView.h"

@implementation UIImage (LGView)

//将UIView转成UIImage
+ (UIImage *)lg_imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, UIScreen.mainScreen.scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
