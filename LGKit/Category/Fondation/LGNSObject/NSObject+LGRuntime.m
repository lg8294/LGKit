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

+ (void)lg_exchangeClassOriginSel:(SEL)originSel customSel:(SEL)customSel {
    Method originMethod = class_getClassMethod(self, originSel);
    Method customMethod = class_getClassMethod(self, customSel);
    
    IMP originImp = class_getMethodImplementation(self, originSel);
    IMP customImp = class_getMethodImplementation(self, customSel);
    
    if (class_addMethod(self, originSel, customImp, method_getTypeEncoding(customMethod))) {
        // 源方法没有实现,直接添加自定义方法的实现
        class_replaceMethod(self, customSel, originImp, method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, customMethod);
    }
}

+ (void)lg_exchangeInstanceOriginSel:(SEL)originSel customSel:(SEL)customSel {
    Method originMethod = class_getInstanceMethod(self, originSel);
    Method customMethod = class_getInstanceMethod(self, customSel);
    
    IMP originImp = class_getMethodImplementation(self, originSel);
    IMP customImp = class_getMethodImplementation(self, customSel);
    
    if (class_addMethod(self, originSel, customImp, method_getTypeEncoding(customMethod))) {
        // 源方法没有实现,直接添加自定义方法的实现
        class_replaceMethod(self, customSel, originImp, method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, customMethod);
    }
}

@end
