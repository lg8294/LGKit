//
//  NSDate+StringFormatter.h
//  AfterSchool
//
//  Created by lg on 15/11/7.
//  Copyright © 2015年 Teson Draw. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 字符串格式
@interface NSDate (LGStringFormatter)

/**
 *  @brief  返回指定格式的时间字符串
 *
 *  @param formatterStr 指定格式（eg:@"yyyy年MM月dd日"）
 *
 *  @return 指定格式的时间字符串
 */
- (NSString *)lg_stringWithFormatter:(NSString *)formatterStr;

/**
 *  @brief  返回默认格式的时间字符串
 *
 *  @return 默认格式的时间字符串（eg:@"yyyy/M/d"）
 */
- (NSString *)lg_defaultString;


/**
 *  change date to string, slicing with hyphen
 *
 *  @return format string like @"2015-11-13"
 */
- (NSString *)lg_formatStringWithHyphen;

/**
 *  时间戳转换为中文日期
 *
 *  @return like @"yyyy年MM月dd日"
 */
- (NSString *)lg_chineseDate;

/**
 *  时间戳转换为中文日期时间
 *
 *  @return like @"yyyy年MM月dd日 HH点mm分"
 */
- (NSString *)lg_chineseDatetime;

/**
 *  时间戳转换为中文-月份和日子
 *
 *  @return like @"12月11日"
 */
- (NSString *)lg_chineseMonthDay;


/**
 *  时间戳转换为短时间（不带秒）
 *
 *  @return like @"13:15"
 */
- (NSString *)lg_time;

@end


#pragma mark - 星座，年龄
@interface NSDate (constellation)
/**
 *  @brief  通过date返回星座
 *
 *  @param date 生日
 *
 *  @return 星座（eg:魔羯座）
 */
+ (NSString *)lg_constellationFromDate:(NSDate *)date;

/**
 *  @brief  通过date返回年龄
 *
 *  @param date 生日
 *
 *  @return 年龄
 */
+ (NSUInteger)lg_ageFromBirthday:(NSDate *)date;

/**
 *  @author lg, 16-03-28 11:03:47
 *
 *  @brief 通过date返回年龄
 *
 *  @return 年龄
 */
- (NSUInteger)lg_age;

@end

