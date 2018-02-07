//
//  NSObject+Runtime.h
//  LGDevelopFramework
//
//  Created by 李刚 on 16/8/2.
//  Copyright © 2016年 李刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LGRuntime)

/*!
 *  @author lg, 16-08-02 10:08:28
 *
 *  @brief 交换类方法
 *
 *  @param method1 方法一
 *  @param method2 方法二
 */
+ (void)lg_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2;

/*!
 *  @author lg, 16-08-02 10:08:50
 *
 *  @brief 交换实例方法
 *
 *  @param method1 方法一
 *  @param method2 方法二
 */
+ (void)lg_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2;


@end
