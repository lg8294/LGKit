//
//  UIView+LGRectCorner.h
//  BaiNian
//
//  Created by lg on 2020/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LGRectCorner)

@property(nonatomic) BOOL lg_enableRectCorner;

- (void)lg_setRectCorner:(UIRectCorner)rectCorner radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
