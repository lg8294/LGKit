//
//  UIButton+LG.h
//  AHCInstitutionClient
//
//  Created by 李刚 on 16/3/22.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIButton (LG)

///设置图片
- (void)lg_setImage:(UIImage *)image placeholderImage:(UIImage *)placeholder forState:(UIControlState)state;

///设置背景色
- (void)lg_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (nullable UIColor *)lg_backgroundColorForState:(UIControlState)state;

///设置图片和标题居中显示
@property (nonatomic, assign) BOOL verticalImageAndTitle;
@property (nonatomic, assign) CGFloat spacing;

- (void)lg_setImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)lg_setTitle:(nullable NSString *)title forState:(UIControlState)state;
- (void)lg_verticalImageAndTitle;

@end


typedef enum : NSUInteger {
    LocationTop,    ///<上
    LocationLeft,   ///<左
    LocationBottom, ///<下
    LocationRight   ///<右
} Location;

@interface UIButton (AddLineAtLocation)

- (void)lg_addLineAtLocation:(Location)location color:(UIColor *)color;

@end
NS_ASSUME_NONNULL_END








