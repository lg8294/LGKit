//
//  LGListItem.m
//  LGKitDemo
//
//  Created by lg on 2017/11/27.
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
