//
//  NSObject+LGEasyKVO.h
//
//  Created by lg on 2017/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KVO 处理 block

 @param obj  被观察者
 @param newValue 新值
 @param oldValue 旧值
 */
typedef void(^LGKVOCompletionHandlerBlock)(id obj, id _Nullable newValue, id _Nullable oldValue);

@interface NSObject (LGEasyKVO)

/**
 添加 KVO，用不着移除观察者，注意处理方式中用 weak 的 self,否则会造成循环引用

 @param observer 观察者
 @param keyPath 键路径
 @param completionHandler 处理方式
 */
- (void)lg_addObserver:(NSObject *)observer
            forkeyPath:(NSString *)keyPath
     completionHandler:(LGKVOCompletionHandlerBlock)completionHandler;

/**
 移除指定观察者对指定键路径的处理方式

 @param observer 指定对象
 @param keyPath 指定键路径
 */
- (void)lg_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/**
 移除指定对象的所有处理方式

 @param observer 指定对象
 */
- (void)lg_removeObserver:(NSObject *)observer;

@end

NS_ASSUME_NONNULL_END
