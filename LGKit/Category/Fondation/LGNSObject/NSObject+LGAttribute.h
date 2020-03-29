//
//  NSObject+LGAttribute.h
//  UISearchControllerTest
//
//  Created by lg on 8/11/2019.
//  Copyright © 2019 lg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LGAttribute)

/// 打印当前类的所有变量和方法
+ (void)lg_logAllAttribute;

/// 保存当前类的所有变量和方法到 plist 文件中
+ (void)lg_saveAllAttribute;

@end

NS_ASSUME_NONNULL_END
