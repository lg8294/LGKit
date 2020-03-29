//
//  NSString+Date.m
//  AHCResidentClient
//
//  Created by 李刚 on 16/3/24.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "NSString+LGDate.h"

@implementation NSString (LGDate)

- (NSDate *)lg_dateFromStringFormatter:(NSString *)formatter {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:self];
}

@end
