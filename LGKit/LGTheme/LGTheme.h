//
//  LGTheme.h
//  LGKit
//
//  Created by lg on 2020/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static inline UIColor* rgba(CGFloat R, CGFloat G, CGFloat B, CGFloat A) {
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A];
}

/// 背景颜色
@interface LGTheme : NSObject

+ (UIColor *)backgroundColor1;
+ (UIColor *)backgroundColor2;
+ (UIColor *)backgroundColor3;
+ (UIColor *)backgroundColor4;

@end


/// 文本颜色
@interface LGTheme (LGText)

+ (UIColor *)textColor1;
+ (UIColor *)textColor2;
+ (UIColor *)textColor3;
+ (UIColor *)textColor4;

@end

/// 字体
@interface LGTheme (LGFont)

+ (UIFont *)textFont1;
+ (UIFont *)textFont2;
+ (UIFont *)textFont3;
+ (UIFont *)textFont4;

@end

NS_ASSUME_NONNULL_END
