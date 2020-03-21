//
//  UIViewController+PIXNoNetwork.h
//  Photon
//
//  Created by lg on 2019/11/25.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PIXNoNetwork)

/// 判断是否显示无网络视图
@property(nonatomic,readonly) BOOL pix_noNetworkShowing;

/// 无网络视图
@property(nonatomic,readonly) UIView *pix_noNetworkView;

/// 无网络时，重新请求事件。子类应该覆盖此方法。
- (void)pix_handleNetworkErrorRetryEvent NS_REQUIRES_SUPER;

/// 显示无网络视图，默认添加到视图控制器的 view 上显示
- (void)pix_showNoNetworkView;

/// 重置网络错误
- (void)pix_resetNoNetwork;

/// 自定义显示和隐藏行为 show: YES（显示行为），NO（重置行为）
@property(nonatomic) void(^pix_customShowAndResetAction)(BOOL show);

@end

NS_ASSUME_NONNULL_END
