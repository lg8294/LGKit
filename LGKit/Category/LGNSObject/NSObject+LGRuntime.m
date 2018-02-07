//
//  NSObject+Runtime.m
//  LGDevelopFramework
//
//  Created by 李刚 on 16/8/2.
//  Copyright © 2016年 李刚. All rights reserved.
//

#import "NSObject+LGRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (LGRuntime)

+ (void)lg_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

+ (void)lg_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

@end
