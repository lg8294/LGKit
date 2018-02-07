//
//  NSObject+LGModel.m
//  AHCInstitutionClient
//
//  Created by 李刚 on 16/3/21.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "NSObject+LGModel.h"
#import "NSObject+LGProperty.h"

NS_ASSUME_NONNULL_BEGIN
@implementation NSObject (LGModel)

+ (instancetype)lg_objectWithDic:(nullable NSDictionary * )dic {
    id object = [[self alloc] init];
    
    NSArray <NSString *> * modelPropertyNames = [self lg_propertys];
    NSArray <NSString *> * dicAllKeys = [dic allKeys];
    
    for (NSString * modelPropertyName in modelPropertyNames) {
        for (NSString * key in dicAllKeys) {
            if ([key.uppercaseString isEqualToString:modelPropertyName.uppercaseString]) {
                if (dic[key]) {
                    [object setValue:dic[key] forKey:modelPropertyName];
                }
            }
        }
    }
    
    return object;
}

@end
NS_ASSUME_NONNULL_END

