//
//  NSObject+swizz.h
//
//  Created by 李刚 on 2017/11/24.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LGSwizzDealloc)

/**
 swizz dealloc
 */
+ (void)lg_swizzDeallocIfNeed;

@end
