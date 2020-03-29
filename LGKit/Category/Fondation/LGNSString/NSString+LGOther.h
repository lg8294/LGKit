//
//  NSString+Other.h
//  AfterSchool
//
//  Created by lg on 15/12/26.
//  Copyright © 2015年 Teson Draw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGOther)

- (NSUInteger)lg_gradeId;

@end

@interface NSString (MD5String)

- (NSString *)lg_MD5String;

@end


@interface NSString (PhoneNumber)

- (BOOL)lg_isMobilePhoneNumber;
- (BOOL)lg_isNumber;
- (BOOL)lg_isFloat;

@end


