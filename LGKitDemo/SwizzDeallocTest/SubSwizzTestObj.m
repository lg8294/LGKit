//
//  SubSwizzTestObj.m
//  LGKitDemo
//
//  Created by iOS on 2017/11/27.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import "SubSwizzTestObj.h"
//#import "NSObject+LGSwizzDealloc.h"
#import <LGKit/NSObject+LGSwizzDealloc.h>

@implementation SubSwizzTestObj
+ (void)load{
    [self lg_swizzDeallocIfNeed];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
