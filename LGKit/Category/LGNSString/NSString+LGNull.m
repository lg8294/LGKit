//
//  NSString+Null.m
//  qisuedu
//
//  Created by apple on 15/4/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSString+LGNull.h"

@implementation NSString (Null)

+ (BOOL)lg_isNull:(NSString *)str {
    return str == nil || [str isKindOfClass:[NSNull class]]|| str.length == 0;
}


@end
