//
//  LGListItem.m
//  LGKitDemo
//
//  Created by iOS on 2017/11/27.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import "LGListItem.h"

@implementation LGListItem

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle content:(NSString *)content handle:(LGListItemHandleBlock)handle
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _subtitle = [subtitle copy];
        _content = [content copy];
        _handle = [handle copy];
    }
    return self;
}

@end
