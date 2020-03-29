//
//  NSObject+LGEasyKVO.m
//
//  Created by lg on 2017/11/23.
//

#import "NSObject+LGEasyKVO.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN
// 用来保存一个 keyPath 的所有 completionHandler

/**
 真实的观察者
 只观察一个 keyPath
 kepPath 的值发生变化后会执行所有需要处理的 block
 */
@interface _LGObserver : NSObject

@property (nonatomic, copy, readonly) NSString * keyPath;

/**
 添加处理方式

 @param handler 处理方式
 @param obj 处理方式的拥有者
 */
- (void)addKVOCompletionHandler:(LGKVOCompletionHandlerBlock)handler forObj:(NSObject *)obj;

/**
 移除处理方式

 @param obj 处理方式的拥有者
 */
- (void)removeKVOCompletionHandlerForObj:(NSObject *)obj;

@end

@implementation _LGObserver {
    NSString *_keyPath;
    NSMutableDictionary *_kvoCompletionHandler;
}

- (instancetype)initWithKeyPath:(NSString *)keyPath
{
    self = [super init];
    if (self) {
        _keyPath = [keyPath copy];
        _kvoCompletionHandler = [@{} mutableCopy];
    }
    return self;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context {
    
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    
    [self handlerWithObject:object newValue:newValue oldValue:oldValue];
}

- (void)handlerWithObject:(id)object newValue:(id)newValue oldValue:(id)oldValue {
    
    [_kvoCompletionHandler enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        LGKVOCompletionHandlerBlock h = obj;
        if (h) {
            h(object, newValue, oldValue);
        }
    }];
}

#pragma mark - public
- (void)addKVOCompletionHandler:(LGKVOCompletionHandlerBlock)handler forObj:(NSObject *)obj {
    [_kvoCompletionHandler setObject:handler forKey:@(obj.hash)];
}

- (void)removeKVOCompletionHandlerForObj:(NSObject *)obj {
    [_kvoCompletionHandler removeObjectForKey:@(obj.hash)];
}
@end

@implementation NSObject (LGEasyKVO)

#pragma mark - swizz dealloc
+ (void)lg_swizzDeallocWithRemoveKVOObserverDeallocIfNeed {
    // 获取标记，检测是否swizz过dealloc
    BOOL swizzed = objc_getAssociatedObject(self.class, @selector(lg_swizzDeallocWithRemoveKVOObserverDeallocIfNeed));
    if (swizzed) {
        return;
    }
    
    // 注册dealloc SEL
    SEL originDeallocSEL = sel_registerName("dealloc");
    // 获取我的dealloc的实现
    IMP overrideRemoveKVOObserverDeallocDeallocIMP = class_getMethodImplementation(self.class, @selector(lg_overrideRemoveKVOObserverDeallocDealloc));
    
    // 尝试添加我的dealloc的实现
    if (class_addMethod(self.class, originDeallocSEL, overrideRemoveKVOObserverDeallocDeallocIMP, "v@:")) {
        // 用户没有实现dealloc,所以成功添加了我的实现
        NSLog(@"add deallocIMP success");
    } else {
        // 用户实现了dealloc,所以添加我的实现失败，然后交换具体的实现
        // 获取用户的实现
        Method userCustomDeallocMethod = class_getInstanceMethod(self.class, originDeallocSEL);
        // 获取我的实现
        Method swizzedDeallocWithRemoveKVOObserverDeallocMethod = class_getInstanceMethod(self.class, @selector(lg_swizzedDeallocWithRemoveKVOObserverDealloc));
        // 交换实现
        method_exchangeImplementations(userCustomDeallocMethod, swizzedDeallocWithRemoveKVOObserverDeallocMethod);
    }
    // 标记swizz过dealloc
    objc_setAssociatedObject(self.class, @selector(lg_swizzDeallocWithRemoveKVOObserverDeallocIfNeed), @(YES), OBJC_ASSOCIATION_RETAIN);
}

- (void)lg_swizzedDeallocWithRemoveKVOObserverDealloc {
    [self lg_removeKVOObserverDealloc];
    [self lg_swizzedDeallocWithRemoveKVOObserverDealloc];
}

- (void)lg_overrideRemoveKVOObserverDeallocDealloc {
    [self lg_removeKVOObserverDealloc];
}

- (void)lg_removeKVOObserverDealloc {
    NSLog(@"%@ removeKVOObserverDealloc", NSStringFromClass(self.class));
    [self lg_removeAllObserver];
}

#pragma mark - private
- (NSMutableDictionary<NSString *,_LGObserver *> *)allKeyPathTarget {
    NSMutableDictionary<NSString *,_LGObserver *> *dic = objc_getAssociatedObject(self, @selector(allKeyPathTarget));
    if (!dic) {
        dic = [@{} mutableCopy];
        objc_setAssociatedObject(self, @selector(allKeyPathTarget), dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

/**
 移除所有观察者（）
 */
- (void)lg_removeAllObserver {
    NSLog(@"%@ removeAllObserver", NSStringFromClass(self.class));
    NSDictionary<NSString *,_LGObserver *> *allRealObserver = [self allKeyPathTarget];
    NSArray<NSString *> *keyPaths = [allRealObserver allKeys];
    for (NSString *keyPath in keyPaths) {
        [self removeObserver:allRealObserver[keyPath] forKeyPath:keyPath];
    }
}

#pragma mark - public
- (void)lg_addObserver:(NSObject *)observer
            forkeyPath:(NSString *)keyPath
     completionHandler:(LGKVOCompletionHandlerBlock)completionHandler {
    
    // 获取真实的观察者
    _LGObserver *realObserver = [[self allKeyPathTarget] valueForKey:keyPath];
    if (!realObserver) {
        // 创建真实的观察者
        realObserver = [[_LGObserver alloc] initWithKeyPath:keyPath];
        // 记录真实的观察者
        [[self allKeyPathTarget] setObject:realObserver forKey:keyPath];
        // 观察 keyPath
        [self addObserver:realObserver forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    
    // 真实观察者添加处理block
    [realObserver addKVOCompletionHandler:completionHandler forObj:observer];
    
    // swizz dealloc if need
    [self.class lg_swizzDeallocWithRemoveKVOObserverDeallocIfNeed];
}

- (void)lg_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSDictionary<NSString *,_LGObserver *> *allRealObserver = [self allKeyPathTarget];
    _LGObserver *realObserver = [allRealObserver objectForKey:keyPath];
    if (realObserver) {
        [realObserver removeKVOCompletionHandlerForObj:observer];
    }
}

- (void)lg_removeObserver:(NSObject *)observer {
    NSDictionary<NSString *,_LGObserver *> *allRealObserver = [self allKeyPathTarget];
    for (_LGObserver *realObserver in allRealObserver) {
        [realObserver removeKVOCompletionHandlerForObj:observer];
    }
}
@end

NS_ASSUME_NONNULL_END
