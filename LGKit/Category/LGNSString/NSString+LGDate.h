//
//  NSString+Date.h
//  AHCResidentClient
//
//  Created by 李刚 on 16/3/24.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGDate)

/**
 *  @author lg, 16-03-24 17:03:29
 *
 *  @brief 按指定格式返回时间
 *
 *  @param formatter 时间格式
 *
 *  @return 时间
 */
- (NSDate *)lg_dateFromStringFormatter:(NSString *)formatter;

@end
