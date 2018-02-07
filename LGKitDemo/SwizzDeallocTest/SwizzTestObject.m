//
//  User.m
//  test
//
//  Created by 李刚 on 2017/11/24.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import "SwizzTestObject.h"
//#import "NSObject+LGSwizzDealloc.h"
#import <LGKit/NSObject+LGSwizzDealloc.h>

@implementation SwizzTestObject

+ (void)load {
    [self lg_swizzDeallocIfNeed];
}

- (void)test {
    NSLog(@"%s", __func__);
}

@end
