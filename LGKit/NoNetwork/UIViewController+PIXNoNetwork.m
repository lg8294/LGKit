//
//  UIViewController+PIXNoNetwork.m
//  Photon
//
//  Created by lg on 2019/11/25.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import "UIViewController+PIXNoNetwork.h"
#import <objc/runtime.h>

@implementation UIViewController (PIXNoNetwork)

- (BOOL)pix_noNetworkShowing {
    BOOL flag = [objc_getAssociatedObject(self, @selector(setPix_noNetworkShowing:)) boolValue];
    return flag;
}
- (void)setPix_noNetworkShowing:(BOOL)pix_noNetworkShowing {
    objc_setAssociatedObject(self, _cmd, @(pix_noNetworkShowing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)pix_noNetworkView
{
    UIView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [view setBackgroundColor:UIColor.whiteColor];
        [view addSubview:[PHDIYEmptyView diyNormalNoNetworkEmptyWithTarget:self action:@selector(pix_handleNetworkErrorRetryEvent) offsetY:kEmptyDefualtOffsetY]];
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)pix_handleNetworkErrorRetryEvent {
    // 由子类实现
    [self pix_resetNoNetwork];
}

- (void)pix_showNoNetworkView {
    if (self.pix_noNetworkShowing) {
        return;
    }
    [self setPix_noNetworkShowing:YES];
    if (self.pix_customShowAndResetAction) {
        self.pix_customShowAndResetAction(YES);
    } else {
        [self pix_defaultShowAction];
    }
}

- (void)pix_resetNoNetwork {
    if (!self.pix_noNetworkShowing) {
        return;
    }
    if (self.pix_customShowAndResetAction) {
        self.pix_customShowAndResetAction(NO);
    } else {
        [self pix_defaultResetAction];
    }
    [self setPix_noNetworkShowing:NO];
}

- (void)setPix_customShowAndResetAction:(void (^)(BOOL))pix_customShowAndResetAction {
    objc_setAssociatedObject(self, _cmd, pix_customShowAndResetAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(BOOL))pix_customShowAndResetAction {
    return objc_getAssociatedObject(self, @selector(setPix_customShowAndResetAction:));
}

#pragma mark - private
- (void)pix_defaultShowAction {
    [self.view addSubview:self.pix_noNetworkView];
}
- (void)pix_defaultResetAction {
    [self.pix_noNetworkView removeFromSuperview];
}
@end
