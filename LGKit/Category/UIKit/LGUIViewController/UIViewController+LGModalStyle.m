//
//  UIViewController+LGModalStyle.m
//  Photon
//
//  Created by lg on 18/11/2019.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import "UIViewController+LGModalStyle.h"
#import <objc/runtime.h>

@implementation UIViewController (LGModalStyle)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(modalPresentationStyle));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(lg_swizzled_modalPresentationStyle));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    self.lg_ModalStyleEnable = YES;
}

+ (BOOL)lg_ModalStyleEnable {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
+ (void)setLg_ModalStyleEnable:(BOOL)lg_ModalStyleEnable {
    objc_setAssociatedObject(self, @selector(lg_ModalStyleEnable), @(lg_ModalStyleEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIModalPresentationStyle)lg_swizzled_modalPresentationStyle {
    
    // 不支持 UIModalPresentationFullScreen 的视图控制器采用默认方式
    for (Class c in [self nonsupport]) {
        if ([self isKindOfClass:c]) {
            return [self lg_swizzled_modalPresentationStyle];
        }
    }
    
    if (UIViewController.lg_ModalStyleEnable) {
        return UIModalPresentationFullScreen;
    } else {
        return [self lg_swizzled_modalPresentationStyle];
    }
}

- (NSArray<Class> *)nonsupport {
    // UISearchController 不支持 UIModalPresentationFullScreen
    return @[UISearchController.class];
}
@end
