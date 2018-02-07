//
//  NSObject+Property.m
//  AfterSchool
//
//  Created by lg on 15/11/2.
//  Copyright © 2015年 Teson Draw. All rights reserved.
//

#import "NSObject+LGProperty.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN
@implementation NSObject (LGProperty)

+ (NSArray <NSString *> *)lg_propertys
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}

@end
NS_ASSUME_NONNULL_END

