//
//  LGListItem.h
//  LGKitDemo
//
//  Created by iOS on 2017/11/27.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LGListItemHandleBlock)(void);

@interface LGListItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) LGListItemHandleBlock handle;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle content:(NSString *)content handle:(LGListItemHandleBlock)handle;

@end
