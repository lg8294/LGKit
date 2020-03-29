//
//  NSObject+PerformBlockAfterDelay.m
//  qisuedu
//
//  Created by apple on 15/3/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSObject+LGPerformBlockAfterDelay.h"

NS_ASSUME_NONNULL_BEGIN
@implementation NSObject (LGPerformBlockAfterDelay)

- (void)lg_performBlock:(nullable void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
}

- (void)fireBlockAfterDelay:(nullable void (^)(void))block
{
    if (block) {
        block();
    }
}


//- (void)runBlockAfterDelay:(NSTimeInterval)delay block:(void (^)(void))block
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*delay),dispatch_get_current_queue(), block);
//}
@end
NS_ASSUME_NONNULL_END

