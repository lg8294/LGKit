//
//  EasyKVOTestObj.m
//  LGKitDemo
//
//  Created by lg on 2017/11/27.
//

#import "EasyKVOTestObj.h"

@implementation EasyKVOTestObj

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _age = age;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", _name);
}

@end
