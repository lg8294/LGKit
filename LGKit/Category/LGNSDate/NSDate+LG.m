//
//  NSDate+StringFormatter.m
//  AfterSchool
//
//  Created by lg on 15/11/7.
//  Copyright © 2015年 Teson Draw. All rights reserved.
//

#import "NSDate+LG.h"

@implementation NSDate (LGStringFormatter)

- (NSString *)lg_stringWithFormatter:(NSString *)formatterStr {
    NSString * result = nil;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    result = [formatter stringFromDate:self];
    return result;
}

- (NSString *)lg_defaultString {

    return [self lg_stringWithFormatter:@"yyyy/MM/dd"];
}

- (NSString *)lg_formatStringWithHyphen {
    return [self lg_stringWithFormatter:@"yyyy-MM-dd"];
}

- (NSString *)lg_chineseDate {
    return [self lg_stringWithFormatter:@"yyyy年MM月dd日"];
}

- (NSString *)lg_chineseDatetime {
    return [self lg_stringWithFormatter:@"yyyy年MM月dd日 HH点mm分"];
}

- (NSString *)lg_chineseMonthDay {
    return [self lg_stringWithFormatter:@"MM月dd日"];
}

- (NSString *)lg_time {
    return [self lg_stringWithFormatter:@"HH:mm"];
}

//- (NSString *)weekDay {
//    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [currentCalendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:self];
//    
//    return [self stringWithFormatter:@"HH:mm"];
//}

@end

@implementation NSDate (constellation)

+ (NSString *)lg_constellationFromDate:(NSDate *)date {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMdd"];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    //    NSUInteger year = [[dateStr substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSUInteger moth = [[dateStr substringWithRange:NSMakeRange(0, 2)] integerValue];;
    NSUInteger day = [[dateStr substringWithRange:NSMakeRange(2, 2)] integerValue];;
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    //    if (moth<1||moth>12||day<1||day>31){
    //        return @"错误日期格式!";
    //    }
    //
    //    if(moth==2 && day>29)
    //    {
    //        return @"错误日期格式!!";
    //    }else if(moth==4 || moth==6 || moth==9 || moth==11) {
    //
    //        if (day>30) {
    //            return @"错误日期格式!!!";
    //        }
    //    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(moth*2-(day < [[astroFormat substringWithRange:NSMakeRange((moth-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@", result];
}

- (NSUInteger)lg_age {
    
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    if (iAge < 0) {
        iAge = 0;
    }
    return iAge;
}

+ (NSUInteger)lg_ageFromBirthday:(NSDate *)date {
    
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    if (iAge < 0) {
        iAge = 0;
    }
    return iAge;
}

-(NSString *)getXingzuo:(NSDate *)in_date
{
    //计算星座
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:in_date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:in_date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}
@end
