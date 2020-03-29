//
//  NSObject+swizz.m
//
//  Created by 李刚 on 2017/11/24.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import "NSObject+LGSwizzDealloc.h"
#import <objc/runtime.h>

@implementation NSObject (LGSwizzDealloc)

+ (void)lg_swizzDeallocIfNeed {
    // 获取标记，检测是否swizz过dealloc
    BOOL swizzed = objc_getAssociatedObject(self.class, @selector(lg_swizzDeallocIfNeed));
    if (swizzed) {
        return;
    }
    
    // 注册dealloc SEL
    SEL originDeallocSEL = sel_registerName("dealloc");
    // 获取我的dealloc的实现
    IMP lgOverrideDeallocIMP = class_getMethodImplementation(self.class, @selector(lg_overrideDealloc));
    
    // 尝试添加我的dealloc的实现
    if (class_addMethod(self.class, originDeallocSEL, lgOverrideDeallocIMP, "v@:")) {
        // 用户没有实现dealloc,所以成功添加了我的实现
        NSLog(@"add deallocIMP success");
    } else {
        // 用户实现了dealloc,所以添加我的实现失败，然后交换具体的实现
        // 获取用户的实现
        Method userCustomDeallocMethod = class_getInstanceMethod(self.class, originDeallocSEL);
        // 获取我的实现
        Method lgSwizzedDeallocMethod = class_getInstanceMethod(self.class, @selector(lg_swizzedDealloc));
        // 交换实现
        method_exchangeImplementations(userCustomDeallocMethod, lgSwizzedDeallocMethod);
    }
    // 标记swizz过dealloc
    objc_setAssociatedObject(self.class, @selector(lg_swizzDeallocIfNeed), @(YES), OBJC_ASSOCIATION_RETAIN);
}

- (void)lg_swizzedDealloc {
    NSLog(@"%@ lg_swizzedDealloc", NSStringFromClass(self.class));
    [self lg_dealloc];
    [self lg_swizzedDealloc];
}

- (void)lg_overrideDealloc {
    NSLog(@"%@ lg_overrideDealloc", NSStringFromClass(self.class));
    [self lg_dealloc];
}

- (void)lg_dealloc {
    NSLog(@"%@ lg_dealloc", NSStringFromClass(self.class));
}

@end
