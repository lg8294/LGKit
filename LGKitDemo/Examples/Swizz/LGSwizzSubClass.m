//
//  LGSwizzSubClass.m
//  LGKitDemo
//
//  Created by lg on 2019/12/27.
//  Copyright © 2019 lg. All rights reserved.
//

#import "LGSwizzSubClass.h"
#import <LGKit/NSObject+LGRuntime.h>

@implementation LGSwizzSubClass
+ (void)initialize {
    [self lg_exchangeInstanceOriginSel:@selector(abc) customSel:@selector(test)];
}

//- (void)customMethod {
//    NSLog(@"IMP的位置：%s", __func__);
//    NSLog(@"SEL的名称：%s", sel_getName(_cmd));
//    [super customMethod];
//}

- (void)test {
    NSLog(@"IMP的位置：%s", __func__);
    NSLog(@"SEL的名称：%s", sel_getName(_cmd));
    [self test];
}
@end
