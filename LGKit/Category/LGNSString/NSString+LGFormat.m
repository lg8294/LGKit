//
//  NSString+Json.m
//  qisuedu
//
//  Created by apple on 15/3/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSString+LGFormat.h"

//    + (NSCharacterSet *)controlCharacterSet;
//    + (NSCharacterSet *)whitespaceCharacterSet;
//    + (NSCharacterSet *)whitespaceAndNewlineCharacterSet;
//    + (NSCharacterSet *)decimalDigitCharacterSet;
//    + (NSCharacterSet *)letterCharacterSet;
//    + (NSCharacterSet *)lowercaseLetterCharacterSet;
//    + (NSCharacterSet *)uppercaseLetterCharacterSet;
//    + (NSCharacterSet *)nonBaseCharacterSet;
//    + (NSCharacterSet *)alphanumericCharacterSet;
//    + (NSCharacterSet *)decomposableCharacterSet;
//    + (NSCharacterSet *)illegalCharacterSet;
//    + (NSCharacterSet *)punctuationCharacterSet;
//    + (NSCharacterSet *)capitalizedLetterCharacterSet;
//    + (NSCharacterSet *)symbolCharacterSet;
//    + (NSCharacterSet *)newlineCharacterSet NS_AVAILABLE(10_5, 2_0);

NS_ASSUME_NONNULL_BEGIN
@implementation NSString (LGFormat)

+ (nullable NSString *)lg_deleteControlCharacter:(NSString *)dataStr
{
    NSScanner *scanner = [[NSScanner alloc] initWithString:dataStr];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSString *temp;
    
    NSCharacterSet * controlCharacters = [NSCharacterSet controlCharacterSet];
    // 扫描
    while (![scanner isAtEnd])
    {
        temp = nil;
        BOOL flag = NO;
        //        [scanner scanCharactersFromSet:newLineCharacters intoString:&temp];
        
        flag = [scanner scanUpToCharactersFromSet:controlCharacters intoString:&temp];
        if (flag) {//找到了控制符
            if (temp) {//控制符之间有内容
                [result appendString:temp];
            }
            //            NSLog(@"%ld", scanner.scanLocation);
            // 替换控制符
            if ([scanner scanCharactersFromSet:controlCharacters intoString:NULL]) {
            }
        }
    }
    return result;
}

+ (nullable NSString *)lg_deleteNewLineAndWhitespaceCharactersInHeadAndEnd:(NSString *)dataStr
{
    return [dataStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (nullable NSString *)lg_deleteControlCharactersSkipNewLineCharacters:(NSString *)dataStr
{
//    NSCharacterSet * newLineCharacters = [NSCharacterSet newlineCharacterSet];
    NSCharacterSet * controlCharacters = [NSCharacterSet controlCharacterSet];
    
    NSScanner *scanner = [[NSScanner alloc] initWithString:dataStr];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *resultTemp = [[NSMutableString alloc] init];
    
    NSString *temp;
    NSString *newLineTemp;
    
    // 扫描
    while (![scanner isAtEnd])
    {
        temp = nil;
        BOOL flag = NO;
        
        flag = [scanner scanUpToCharactersFromSet:controlCharacters intoString:&temp];
        if (flag) {//找到了控制符
            if (temp) {//控制符之间有内容
                [resultTemp appendString:temp];
            }
//            NSLog(@"%ld", scanner.scanLocation);
            // 替换换行符
            if ([scanner scanCharactersFromSet:controlCharacters intoString:&newLineTemp]) {
//                NSLog(@"%ld", scanner.scanLocation);
//                NSLog(@"%@", newLineTemp);
//
//                NSString * string = [newLineTemp stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\r\\n"];
//                NSLog(@"%@", string);

                if (resultTemp.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                {
                    NSRange range = [newLineTemp rangeOfString:@"\r\n"];
//                    NSLog(@"add huan hang");
                    if (range.length > 0) {
                        
                        [resultTemp appendString:@"\\r\\n"];
                    }
                }
            }
        }
    }

    return resultTemp;
}

//基础语法 "^([]{})([]{})([]{})$"
//正则字符串 = "开始（[包含内容]{长度}）（[包含内容]{长度}）（[包含内容]{长度}）结束"

//年-月-日((((1[6-9]|[2-9]\d)\d{2})-(1[02]|0?[13578])-([12]\d|3[01]|0?[1-9]))|(((1[6-9]|[2-9]\d)\d{2})-(1[012]|0?[13456789])-([12]\d|30|0?[1-9]))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(1\d|2[0-8]|0?[1-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)lg_isMobileNumber {
    
    NSString *phoneRegex = @"(13\\d|14[57]|15[^4\\D]|17[678]|18\\d)\\d{8}|170[059]\\d{7}";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

/*邮箱验证 MODIFIED BY HELENSONG*/
- (BOOL)lg_isEmail {
    NSString *emailRegex = @"\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)lg_matchPredicate:(NSString *)predicateStr {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predicateStr];
    
    return [predicate evaluateWithObject:self];
}

- (NSArray <NSString *> *)lg_match:(NSString *)regularStr error:(NSError *)error {
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regularStr options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:&error];
    //无视大小写.
    NSArray *matches = [reg matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, [self length])];
    
    NSMutableArray <NSString *> * resultArray = [NSMutableArray new];
    
    int i = 0;
    for (NSTextCheckingResult *match in matches) {
        i++;
        NSRange range = [match range];
        NSString * subStr = [self substringWithRange:range];
        
        [resultArray addObject:subStr];
        NSLog(@"%@,%@", NSStringFromRange(range), subStr);
    }
    
    return [resultArray copy];
}
@end
NS_ASSUME_NONNULL_END

