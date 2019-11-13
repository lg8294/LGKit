//
//  UIScrollView+ScreenShot.m
//  AfterSchool
//
//  Created by lg on 16/1/5.
//  Copyright © 2016年 Teson Draw. All rights reserved.
//

#import "UIScrollView+LGScreenShot.h"

NS_ASSUME_NONNULL_BEGIN
@implementation UIScrollView (LGScreenShot)

/**
 *截图
 */
- (nullable UIImage *)lg_screenShot{
    
    CGPoint savedContentOffset = self.contentOffset;
    CGRect savedFrame = self.frame;
    
    self.contentOffset = CGPointZero;
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(self.contentSize, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.contentOffset = savedContentOffset;
    self.frame = savedFrame;
    
    if (screenShotImage != nil) {
        NSLog(@"截图成功!");
    }  
    return screenShotImage;
}
@end
NS_ASSUME_NONNULL_END


