//
//  NSString+Json.h
//  qisuedu
//
//  Created by apple on 15/3/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (LGFormat)
/**
 *  删除字符串中的控制符
 *
 *  @param dataStr 原始字符串
 *
 *  @return 返回的字符串
 */
+ (nullable NSString *)lg_deleteControlCharacter:(NSString *)dataStr;

/**
 *  删除字符串中除换行符的其他字符
 *
 *  @param dataStr 原始字符串
 *
 *  @return 返回的字符串
 */
+ (nullable NSString *)lg_deleteControlCharactersSkipNewLineCharacters:(NSString *)dataStr;

/**
 *  删除字符串头尾的空格和换行
 *
 *  @param dataStr 原始字符串
 *
 *  @return 返回的字符串
 */
+ (nullable NSString *)lg_deleteNewLineAndWhitespaceCharactersInHeadAndEnd:(NSString *)dataStr;


- (BOOL)lg_isMobileNumber;
- (BOOL)lg_isEmail;
- (BOOL)lg_matchPredicate:(NSString *)predicateStr;

/**
 *  @author lg, 16-05-06 23:05:04
 *
 *  @brief 正则匹配
 *
 *  @param regularStr 正则匹配字符串
 *  @param error      错误信息
 *
 *  @return 匹配结果
 */
- (NSArray <NSString *> *)lg_match:(NSString *)regularStr error:(NSError *)error;

@end
NS_ASSUME_NONNULL_END

