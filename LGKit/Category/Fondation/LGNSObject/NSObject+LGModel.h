//
//  NSObject+LGModel.h
//  AHCInstitutionClient
//
//  Created by 李刚 on 16/3/21.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (LGModel)

/**
 *  @author lg, 16-03-22 19:03:32
 *
 *  @brief 通过字典给模型赋值
 *
 *  @param dic 字典（key值为模型的属性名称）
 *
 *  @return 模型
 */
+ (instancetype)lg_objectWithDic:(nullable NSDictionary *)dic;

@end
NS_ASSUME_NONNULL_END

