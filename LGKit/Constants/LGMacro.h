//
//  LGMacro.h
//  LGKit
//
//  Created by lg on 2019/12/26.
//  Copyright © 2019 lg. All rights reserved.
//

#ifndef LGMacro_h
#define LGMacro_h

/// AppDelegate
#define APP ((AppDelegate *)[UIApplication sharedApplication].delegate)
/// KeyWindow
#define kKeyWindow ({ \
    NSArray *windows = [UIApplication sharedApplication].windows; \
    UIWindow *window; \
    for (UIWindow *w in windows) { \
        if (w.isKeyWindow) { \
            window = w; \
            break; \
        } \
    } \
    window; \
})

/// 屏幕宽度
#define kScreenW UIScreen.mainScreen.bounds.size.width
/// 屏幕高度
#define kScreenH UIScreen.mainScreen.bounds.size.height

/// 弱引用指定对象
#define kWeakify(NAME, TARGET) __weak typeof(TARGET) NAME = TARGET;
/// 弱引用self
#define kWeakSelf kWeakify(weakSelf, self);

#define lg_weakObj(obj) __weak type(obj) weak_##obj=obj
#define lg_strongObj(obj) __strong type(obj) strong_##obj=obj

#define lg_weakSelf __weak type(self) weakSelf=self
#define lg_strongSelf __strong type(weakSelf) strongSelf=weakSelf

#endif /* LGMacro_h */
