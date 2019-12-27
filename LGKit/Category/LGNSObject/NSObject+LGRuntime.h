//
//  NSObject+Runtime.h
//  LGDevelopFramework
//
//  Created by 李刚 on 16/8/2.
//  Copyright © 2016年 李刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LGRuntime)

/// 交换类方法，如果源方法没有实现，直接添加自定义方法的实现
/// @param originSel 源方法
/// @param customSel 自定义方法
+ (void)lg_exchangeClassOriginSel:(SEL)originSel customSel:(SEL)customSel;

/// 交换实例方法，如果源方法没有实现，直接添加自定义方法的实现
/// @param originSel 源方法
/// @param customSel 自定义方法
+ (void)lg_exchangeInstanceOriginSel:(SEL)originSel customSel:(SEL)customSel;

@end
