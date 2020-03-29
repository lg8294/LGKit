//
//  UIBarButtonItem+LGHelper.h
//  Photon
//
//  Created by lg on 2020/2/11.
//  Copyright © 2020 everimaging. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (LGHelper)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImageNames:(NSArray<NSString *> *)imageNames target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
