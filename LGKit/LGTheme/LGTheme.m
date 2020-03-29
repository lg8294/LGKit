//
//  LGTheme.m
//  LGKit
//
//  Created by lg on 2020/3/29.
//

#import "LGTheme.h"

/// 背景色
@implementation LGTheme

+ (UIColor *)backgroundColor1 {
    return rgba(0, 0, 0, 1);
}
+ (UIColor *)backgroundColor2 {
    return rgba(0, 0, 0, 1);
}
+ (UIColor *)backgroundColor3 {
    return rgba(0, 0, 0, 1);
}
+ (UIColor *)backgroundColor4 {
    return rgba(0, 0, 0, 1);
}

@end

/// 文本颜色
@implementation LGTheme (LGText)

+ (UIColor *)textColor1 {
    return rgba(0, 0, 0, 1);
}

+ (UIColor *)textColor2 {
    return rgba(0, 0, 0, 1);
}

+ (UIColor *)textColor3 {
    return rgba(0, 0, 0, 1);
}

+ (UIColor *)textColor4 {
    return rgba(0, 0, 0, 1);
}

@end

/// 字体
@implementation LGTheme (LGFont)

+ (UIFont *)textFont1 {
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)textFont2 {
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)textFont3 {
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)textFont4 {
    return [UIFont systemFontOfSize:14];
}

@end
