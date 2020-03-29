//
//  EasyKVOTestObj.h
//  LGKitDemo
//
//  Created by lg on 2017/11/27.
//

#import <Foundation/Foundation.h>

@interface EasyKVOTestObj : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) EasyKVOTestObj *people;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;

@end
