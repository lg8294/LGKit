//
//  UIImageView+LG.h
//  AHCResidentClient
//
//  Created by 李刚 on 16/4/1.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LG)

- (void)lg_addCorner:(CGFloat)radius;

- (void)lg_setImage:(UIImage *)image placeholderImage:(UIImage *)placeholder;
@end
