//
//  NSObject+Attribute.m
//  UISearchControllerTest
//
//  Created by lg on 8/11/2019.
//  Copyright © 2019 lg. All rights reserved.
//

#import "NSObject+Attribute.h"
#import <objc/runtime.h>

@implementation NSObject (Attribute)

+ (void)lg_logAllAttribute {
    NSLog(@"Ivar List:");
    NSLog(@"%@", [self lg_allIvar]);
    NSLog(@"Property List:");
    NSLog(@"%@", [self lg_allProperty]);
    NSLog(@"Method List:");
    NSLog(@"%@", [self lg_allMethod]);
}

+ (void)lg_logAllAttribute1 {
    uint ivarCount = 0;
    uint methodCount = 0;
    uint propertyCount = 0;
    
    Ivar *ivarArray = class_copyIvarList(self, &ivarCount);
    Method *methodArray = class_copyMethodList(self, &methodCount);
    objc_property_t *propertyList = class_copyPropertyList(self, &propertyCount);
    
    NSLog(@"Property List:");
    for (uint i=0; i<propertyCount; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        
        NSLog(@"%s",propertyName);
    }
    
    NSLog(@"Method List:");
    for (uint i=0; i< methodCount; i++) {
        Method method = methodArray[i];
        // 方法名称
        SEL methodName = method_getName(method);
        
        // 返回类型 (v == void)
        char returnType[50];
        method_getReturnType(method, returnType, 50);
        
        // 参数类型 (@: == self) (B == BOOL) (@ == Object) (q == ENUM) (d == double)
        uint argCount = method_getNumberOfArguments(method);
        char argsStr[1000];
        strcpy(argsStr, "");
        for (unsigned int j = 0; j<argCount; j++) {
            char argumentType[100];
            method_getArgumentType(method, j, argumentType, 100);
            strcat(argsStr, argumentType);
        }
        
        //(返回类型)方法名称(参数类型)
        NSLog(@"(%s)%@(%s)", returnType,NSStringFromSelector(methodName),argsStr);
    }
    
    NSLog(@"Ivar List:");
    for (uint i=0; i< ivarCount; i++) {
        Ivar ivar = ivarArray[i];
        const char *ivarName = ivar_getName(ivar);
        NSLog(@"%s", ivarName);
    }
}

+ (NSArray<NSString *> *)lg_allIvar {

    NSMutableArray<NSString *> *list = [@[] mutableCopy];
    
    uint ivarCount = 0;
    Ivar *ivarArray = class_copyIvarList(self, &ivarCount);
    for (uint i=0; i< ivarCount; i++) {
        Ivar ivar = ivarArray[i];
        const char *ivarName = ivar_getName(ivar);
        [list addObject:[NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding]];
    }
    
    return [list copy];
}

+ (NSArray<NSString *> *)lg_allProperty {

    NSMutableArray<NSString *> *list = [@[] mutableCopy];
    
    uint propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(self, &propertyCount);
    
    for (uint i=0; i<propertyCount; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [list addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    
    return [list copy];
}

+ (NSArray<NSString *> *)lg_allMethod {

    NSMutableArray<NSString *> *list = [@[] mutableCopy];
    
    uint methodCount = 0;
    Method *methodArray = class_copyMethodList(self, &methodCount);
    
    for (uint i=0; i< methodCount; i++) {
        Method method = methodArray[i];
        // 方法名称
        SEL methodName = method_getName(method);
        
        // 返回类型 (v == void)
        char returnType[50];
        method_getReturnType(method, returnType, 50);
        
        // 参数类型 (@: == self) (B == BOOL) (@ == Object) (q == ENUM) (d == double)
        uint argCount = method_getNumberOfArguments(method);
        char argsStr[1000];
        strcpy(argsStr, "");
        for (unsigned int j = 0; j<argCount; j++) {
            char argumentType[100];
            method_getArgumentType(method, j, argumentType, 100);
            strcat(argsStr, argumentType);
        }
        
        //(返回类型)方法名称(参数类型)
        [list addObject:[NSString stringWithFormat:@"(%s)%@(%s)", returnType,NSStringFromSelector(methodName),argsStr]];
//        NSLog(@"(%s)%@(%s)", returnType,NSStringFromSelector(methodName),argsStr);
    }
    
    return [list copy];
}

+ (void)lg_saveAllAttribute {
    NSMutableDictionary *dic = [@{} mutableCopy];
    
    [dic setObject:[self lg_allIvar] forKey:@"Ivar"];
    [dic setObject:[self lg_allProperty] forKey:@"Property"];
    [dic setObject:[self lg_allMethod] forKey:@"Method"];
    
    NSString *path = NSTemporaryDirectory();
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%f.plist", NSStringFromClass(self), [NSDate new].timeIntervalSince1970]];
    NSLog(@"保存路径：%@",path);
    [dic writeToFile:path atomically:YES];
}

@end
