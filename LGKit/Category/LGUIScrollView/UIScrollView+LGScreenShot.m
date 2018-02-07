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
    UIImage* screenShotImage = nil;
    float scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(self.contentSize, NO, scale);
    
    CGPoint savedContentOffset = self.contentOffset;
    CGRect savedFrame = self.frame;
    self.contentOffset = CGPointZero;
    
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    
    screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.contentOffset = savedContentOffset;
    self.frame = savedFrame;

    UIGraphicsEndImageContext();
    
    if (screenShotImage != nil) {
        NSLog(@"截图成功!");
    }  
    return screenShotImage;
}
@end
NS_ASSUME_NONNULL_END


