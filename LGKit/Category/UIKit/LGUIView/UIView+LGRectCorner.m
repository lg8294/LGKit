//
//  UIView+LGRectCorner.m
//  BaiNian
//
//  Created by lg on 2020/3/29.
//

#import "UIView+LGRectCorner.h"
#import <objc/runtime.h>

@implementation UIView (LGRectCorner)
+ (void)load {
    Method origin_method = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method swizzed_method = class_getInstanceMethod(self, @selector(lg_swizzed_layoutSubviews));
    method_exchangeImplementations(origin_method, swizzed_method);
}

- (BOOL)lg_enableRectCorner {
    NSNumber *v = objc_getAssociatedObject(self, @selector(setLg_enableRectCorner:));
    if (v) {
        return v.boolValue;
    }
    return NO;
}
- (void)setLg_enableRectCorner:(BOOL)lg_enableRectCorner {
    objc_setAssociatedObject(self, _cmd, @(lg_enableRectCorner), OBJC_ASSOCIATION_RETAIN);
    [self setNeedsLayout];
}

- (UIRectCorner)_lg_rectCorner {
    NSNumber *v = objc_getAssociatedObject(self, @selector(set_lg_rectCorner:));
    return v.integerValue;
}
- (void)set_lg_rectCorner:(UIRectCorner)rectCorner {
    objc_setAssociatedObject(self, _cmd, @(rectCorner), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)_lg_rectCorner_radius {
    NSNumber *v = objc_getAssociatedObject(self, @selector(set_lg_rectCorner_radius:));
    return v.integerValue;
}
- (void)set_lg_rectCorner_radius:(UIRectCorner)rectCorner_radius {
    objc_setAssociatedObject(self, _cmd, @(rectCorner_radius), OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)_lg_rectCorner_maskLayer {
    id v = objc_getAssociatedObject(self, @selector(set_lg_rectCorner_maskLayer:));
    return v;
}
- (void)set_lg_rectCorner_maskLayer:(CAShapeLayer *)rectCorner_maskLayer {
    objc_setAssociatedObject(self, _cmd, rectCorner_maskLayer, OBJC_ASSOCIATION_RETAIN);
}

- (UIBezierPath *)_lg_rectCorner_maskPath {
    id v = objc_getAssociatedObject(self, @selector(set_lg_rectCorner_maskPath:));
    return v;
}
- (void)set_lg_rectCorner_maskPath:(UIBezierPath *)rectCorner_maskPath {
    objc_setAssociatedObject(self, _cmd, rectCorner_maskPath, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark -
- (void)lg_setRectCorner:(UIRectCorner)rectCorner radius:(CGFloat)radius {
    self._lg_rectCorner = rectCorner;
    self._lg_rectCorner_radius = radius;
    [self setNeedsLayout];
}

- (void)lg_swizzed_layoutSubviews {
    [self lg_swizzed_layoutSubviews];
    
    if (self.lg_enableRectCorner) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self._lg_rectCorner cornerRadii:CGSizeMake(self._lg_rectCorner_radius, self._lg_rectCorner_radius)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self._lg_rectCorner_maskLayer = maskLayer;
        
        if (self._lg_rectCorner == 0) {
            self.layer.mask = nil;
        } else {
            self.layer.mask = self._lg_rectCorner_maskLayer;
        }
    }
}

@end
