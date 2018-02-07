//
//  NSObject+PerformBlockAfterDelay.h
//  qisuedu
//
//  Created by apple on 15/3/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (LGPerformBlockAfterDelay)

/**
 *  @author lg, 16-03-22 19:03:19
 *
 *  @brief block方式延时执行
 *
 *  @param block 延时执行的block
 *  @param delay 延时时间
 */
- (void)lg_performBlock:(nullable void (^)(void))block afterDelay:(NSTimeInterval)delay;

//- (void)runBlockAfterDelay:(NSTimeInterval)delay block:(void (^)(void))block;

@end
NS_ASSUME_NONNULL_END
