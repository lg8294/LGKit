//
//  SubSwizzTestObj.m
//  LGKitDemo
//
//  Created by lg on 2017/11/27.
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
