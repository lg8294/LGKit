//
//  UIViewController+LGModalStyle.h
//  Photon
//
//  Created by lg on 18/11/2019.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 适配 iOS13，默认采用 iOS13 以前的模态显示方式
@interface UIViewController (LGModalStyle)

/// LGModalStyle 开关，YES：开 ，NO：关。默认 YES；
@property (nonatomic,class) BOOL lg_ModalStyleEnable;

@end

NS_ASSUME_NONNULL_END
