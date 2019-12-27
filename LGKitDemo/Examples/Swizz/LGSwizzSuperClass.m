//
//  LGSwizzSuperClass.m
//  LGKitDemo
//
//  Created by lg on 2019/12/27.
//  Copyright © 2019 lg. All rights reserved.
//

#import "LGSwizzSuperClass.h"

@implementation LGSwizzSuperClass

- (void)customMethod {
    NSLog(@"IMP的位置：%s", __func__);
    NSLog(@"SEL的名称：%s", sel_getName(_cmd));
//    NSLog(@"%d", __LINE__);
//    NSLog(@"%s", __DATE__);
//    NSLog(@"%s", __FILE__);
}
@end
