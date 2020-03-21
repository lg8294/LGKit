//
//  UIViewController+LGStatusBar.h
//  HideStatusBarDemo
//
//  Created by lg on 31/10/2019.
//  Copyright © 2019 lg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LGStatusBar)

@property(nonatomic) BOOL lg_enableStatusBarManager;///<是否开启状态栏管理，YES:开启，NO:关闭，默认 NO
@property(nonatomic) BOOL lg_prefersStatusBarHidden;///<状态栏是否隐藏，YES:隐藏，NO:显示，默认 NO

@end

NS_ASSUME_NONNULL_END
