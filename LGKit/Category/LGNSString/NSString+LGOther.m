//
//  NSString+Other.m
//  AfterSchool
//
//  Created by lg on 15/12/26.
//  Copyright © 2015年 Teson Draw. All rights reserved.
//

#import "NSString+LGOther.h"

@implementation NSString (LGOther)

- (NSUInteger)lg_gradeId {
    if ([self isEqualToString:@"无段位"]) {
        return 0;
    } else if ([self isEqualToString:@"青铜V"]) {
        return 1;
    } else if ([self isEqualToString:@"青铜V"]) {
        return 11;
    } else if ([self isEqualToString:@"青铜IV"]) {
        return 12;
    } else if ([self isEqualToString:@"青铜III"]) {
        return 13;
    } else if ([self isEqualToString:@"青铜II"]) {
        return 14;
    } else if ([self isEqualToString:@"青铜I"]) {
        return 15;
    } else if ([self isEqualToString:@"白银V"]) {
        return 21;
    } else if ([self isEqualToString:@"白银IV"]) {
        return 22;
    } else if ([self isEqualToString:@"白银III"]) {
        return 23;
    } else if ([self isEqualToString:@"白银II"]) {
        return 24;
    } else if ([self isEqualToString:@"白银I"]) {
        return 25;
    } else if ([self isEqualToString:@"黄金V"]) {
        return 31;
    } else if ([self isEqualToString:@"黄金IV"]) {
        return 32;
    } else if ([self isEqualToString:@"黄金III"]) {
        return 33;
    } else if ([self isEqualToString:@"黄金II"]) {
        return 34;
    } else if ([self isEqualToString:@"黄金I"]) {
        return 35;
    } else if ([self isEqualToString:@"白金V"]) {
        return 41;
    } else if ([self isEqualToString:@"白金IV"]) {
        return 42;
    } else if ([self isEqualToString:@"白金III"]) {
        return 43;
    } else if ([self isEqualToString:@"白金II"]) {
        return 44;
    } else if ([self isEqualToString:@"白金I"]) {
        return 45;
    } else if ([self isEqualToString:@"钻石V"]) {
        return 51;
    } else if ([self isEqualToString:@"钻石IV"]) {
        return 52;
    } else if ([self isEqualToString:@"钻石III"]) {
        return 53;
    } else if ([self isEqualToString:@"钻石II"]) {
        return 54;
    } else if ([self isEqualToString:@"钻石I"]) {
        return 55;
    } else if ([self isEqualToString:@"超凡大师"]) {
        return 61;
    } else if ([self isEqualToString:@"最强王者"]) {
        return 71;
    }
    return 0;
}
@end

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5String)
- (NSString *)lg_MD5String {
    
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}
@end

@implementation NSString (PhoneNumber)

- (BOOL)lg_isMobilePhoneNumber {
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)lg_isNumber {
    NSScanner * scanner = [NSScanner scannerWithString:self];
    int value;
    return[scanner scanInt:&value] && [scanner isAtEnd];
}

//判断是否为整形：
- (BOOL)lg_isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)lg_isFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end




