//
//  UIViewController+LGNoNetworkView.m
//
//  Created by lg on 2019/11/25.
//

#import "UIViewController+LGNoNetworkView.h"
#import <objc/runtime.h>
#import "LGMacro.h"

@implementation UIViewController (LGNoNetworkView)

- (BOOL)lg_noNetworkShowing {
    BOOL flag = [objc_getAssociatedObject(self, @selector(setLg_noNetworkShowing:)) boolValue];
    return flag;
}
- (void)setLg_noNetworkShowing:(BOOL)lg_noNetworkShowing {
    objc_setAssociatedObject(self, _cmd, @(lg_noNetworkShowing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lg_noNetworkView
{
    UIView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        [view setBackgroundColor:UIColor.whiteColor];
//        [view addSubview:[PHDIYEmptyView diyNormalNoNetworkEmptyWithTarget:self action:@selector(lg_handleNetworkErrorRetryEvent) offsetY:kEmptyDefualtOffsetY]];
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)lg_handleNetworkErrorRetryEvent {
    // 由子类实现
    [self lg_resetNoNetwork];
}

- (void)lg_showNoNetworkView {
    if (self.lg_noNetworkShowing) {
        return;
    }
    [self setLg_noNetworkShowing:YES];
    if (self.lg_customShowAndResetAction) {
        self.lg_customShowAndResetAction(YES);
    } else {
        [self lg_defaultShowAction];
    }
}

- (void)lg_resetNoNetwork {
    if (!self.lg_noNetworkShowing) {
        return;
    }
    if (self.lg_customShowAndResetAction) {
        self.lg_customShowAndResetAction(NO);
    } else {
        [self lg_defaultResetAction];
    }
    [self setLg_noNetworkShowing:NO];
}

- (void)setLg_customShowAndResetAction:(void (^)(BOOL))lg_customShowAndResetAction {
    objc_setAssociatedObject(self, _cmd, lg_customShowAndResetAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(BOOL))lg_customShowAndResetAction {
    return objc_getAssociatedObject(self, @selector(setLg_customShowAndResetAction:));
}

#pragma mark - private
- (void)lg_defaultShowAction {
    [self.view addSubview:self.lg_noNetworkView];
}
- (void)lg_defaultResetAction {
    [self.lg_noNetworkView removeFromSuperview];
}
@end
