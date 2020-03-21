//
//  UIViewController+LGStatusBar.m
//  HideStatusBarDemo
//
//  Created by lg on 31/10/2019.
//  Copyright © 2019 lg. All rights reserved.
//

#import "UIViewController+LGStatusBar.h"
#import <objc/runtime.h>

@implementation UIViewController (LGStatusBar)

+ (void)load
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"    
    Method originalMethod = class_getInstanceMethod(self, @selector(_preferredStatusBarVisibility));
#pragma clang diagnostic pop
    Method swizzledMethod = class_getInstanceMethod(self, @selector(lg_swizzled_preferredStatusBarVisibility));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (BOOL)lg_swizzled_preferredStatusBarVisibility {
    if (self.lg_enableStatusBarManager) {
        return self.lg_prefersStatusBarHidden;
    } else {
        return [self lg_swizzled_preferredStatusBarVisibility];
    }
}

#pragma mark lg_enableStatusBarManager
- (BOOL)lg_enableStatusBarManager {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLg_enableStatusBarManager:(BOOL)lg_enableStatusBarManager {
    objc_setAssociatedObject(self, @selector(lg_enableStatusBarManager), @(lg_enableStatusBarManager), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark lg_prefersStatusBarHidden
- (BOOL)lg_prefersStatusBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLg_prefersStatusBarHidden:(BOOL)lg_prefersStatusBarHidden {
    objc_setAssociatedObject(self, @selector(lg_prefersStatusBarHidden), @(lg_prefersStatusBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
