//
//  TestTableViewItem.m
//  LGKitDemo
//
//  Created by lg on 2019/12/26.
//  Copyright © 2019 lg. All rights reserved.
//

#import "TestTableViewItem.h"

@implementation TestTableViewItem

@synthesize cellClass = _cellClass;
- (Class)cellClass {
    NSException *exception = [NSException exceptionWithName:@"" reason:@"子类必需实现此方法" userInfo:nil];
    [exception raise];
    
    return nil;
}

@end
