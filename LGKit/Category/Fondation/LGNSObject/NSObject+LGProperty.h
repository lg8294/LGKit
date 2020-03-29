//
//  NSObject+Property.h
//  AfterSchool
//
//  Created by lg on 15/11/2.
//  Copyright © 2015年 Teson Draw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (LGProperty)

/**
 *  @author lg, 16-03-22 19:03:55
 *
 *  @brief 返回类的属性名称
 *
 *  @return 属性名称集合
 */
+ (NSArray <NSString *> *)lg_propertys;

@end
NS_ASSUME_NONNULL_END
