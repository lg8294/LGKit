//
//  UIButton+LG.m
//  AHCInstitutionClient
//
//  Created by 李刚 on 16/3/22.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "UIButton+LG.h"
#import "NSObject+LGRuntime.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

static const char BackgroundColorForStateKey;

@implementation UIButton (LG)

- (void)lg_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    NSString * key = [self keyForState:state];
    
    if (backgroundColor) {
        if (state == UIControlStateNormal) {
            [self setBackgroundColor:backgroundColor];
        }
        [self.backgroundColors setObject:backgroundColor forKey:key];
    }
}

+ (void)load {
    [self lg_exchangeInstanceOriginSel:@selector(setHighlighted:) customSel:@selector(lg_setHighlighted:)];
    [self lg_exchangeInstanceOriginSel:@selector(setSelected:) customSel:@selector(lg_setSelected:)];
    [self lg_exchangeInstanceOriginSel:@selector(setEnabled:) customSel:@selector(lg_setEnabled:)];
}

- (NSString *)keyForState:(UIControlState)state {
    return [NSString stringWithFormat:@"backgroundColorState_%lu", (unsigned long)state];
}

- (nonnull NSMutableDictionary *)backgroundColors {
    NSMutableDictionary * backgroundColors = objc_getAssociatedObject(self, &BackgroundColorForStateKey);
    if (!backgroundColors) {
        backgroundColors = [NSMutableDictionary new];
        NSString *normalKey = [self keyForState:UIControlStateNormal];
        if (self.backgroundColor) {
            [backgroundColors setObject:self.backgroundColor forKey:normalKey];
        }
        objc_setAssociatedObject(self, &BackgroundColorForStateKey, backgroundColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backgroundColors;
}

- (void)lg_setHighlighted:(BOOL)highlighted {
    //执行原来的 setHighlighted 方法
    [self lg_setHighlighted:highlighted];
    [self setHighlightedBackgroundColor];
}

- (void)lg_setEnabled:(BOOL)enabled {
    [self lg_setEnabled:enabled];
    [self setDisabledBackgroundColor];
}

- (void)lg_setSelected:(BOOL)selected {
    //执行原来的 setSelected 方法
    [self lg_setSelected:selected];
    if ([self isEnabled]) {
        [self setSelectedBackgroundColor];
    }
}

- (void)setSelectedBackgroundColor {
    NSString *selectedKey = [self keyForState:UIControlStateSelected];
    UIColor *selectedColor = [self.backgroundColors valueForKey:selectedKey];
    if ([self isSelected] && selectedColor) {
        [self setBackgroundColor:selectedColor];
    } else {
        NSString *normalKey = [self keyForState:UIControlStateNormal];
        [self setBackgroundColor:[self.backgroundColors valueForKey:normalKey]];
    }
}

- (void)setDisabledBackgroundColor {
    NSString *disabledKey = [self keyForState:UIControlStateDisabled];
    UIColor *disabledColor = [self.backgroundColors valueForKey:disabledKey];
    if (![self isEnabled] && disabledColor) {
        [self setBackgroundColor:disabledColor];
    } else {
        [self setSelectedBackgroundColor];
    }
}

- (void)setHighlightedBackgroundColor {
    NSString *highlightedKey = [self keyForState:UIControlStateHighlighted];
    UIColor *highlightedColor = [self.backgroundColors valueForKey:highlightedKey];
    if ([self isHighlighted] && highlightedColor) {
        [self setBackgroundColor:highlightedColor];
    } else {
        // 由于系统在调用setSelected 或 setEnabled后，会再触发一次setHighlighted，故做如下处理，否则，背景色会被最后一次的覆盖掉。
        [self setDisabledBackgroundColor];
    }
}

- (nullable UIColor *)lg_backgroundColorForState:(UIControlState)state {
    NSString * key = [self keyForState:state];
    
    if (key) {
        return [self.backgroundColors objectForKey:key];
    }
    return nil;
}

static char verticalIamgeAndTitleKey;
static char spacingKey;

- (void)setVerticalImageAndTitle:(BOOL)verticalImageAndTitle {
    objc_setAssociatedObject(self, &verticalIamgeAndTitleKey, @(verticalImageAndTitle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)verticalImageAndTitle {
    return [objc_getAssociatedObject(self,&verticalIamgeAndTitleKey) boolValue];
}

- (void)setSpacing:(CGFloat)spacing {
    objc_setAssociatedObject(self, &spacingKey, @(spacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)spacing {
    return [objc_getAssociatedObject(self, &spacingKey) floatValue];
}

- (void)lg_setTitle:(nullable NSString *)title forState:(UIControlState)state {
    [self setTitle:title forState:state];
    
    if (self.verticalImageAndTitle) {
        [self lg_verticalImageAndTitle];
    }
}

- (void)lg_setImage:(nullable UIImage *)image forState:(UIControlState)state {
    [self setImage:image forState:state];
    
    if (self.verticalImageAndTitle) {
        [self lg_verticalImageAndTitle];
    }
}

- (void)lg_verticalImageAndTitle {
    
    NSDictionary * attributes = @{NSFontAttributeName:self.titleLabel.font};
    
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:self.bounds.size
                                                          options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                       attributes:attributes
                                                          context:nil].size;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, titleSize.height + self.spacing, -titleSize.width)];
    
    CGSize imageSize = self.imageView.image.size;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + self.spacing, -imageSize.width, 0, 0)];
}

@end

@implementation UIButton (AddLineAtLocation)

- (void)lg_addLineAtLocation:(Location)location color:(UIColor *)color {
    
    UIView *lineView = [[UIView alloc] init];
    
    if (color) {
        lineView.backgroundColor = color;
    } else {
        lineView.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
    }
    
    switch (location) {
        case LocationTop:
            lineView.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
            break;
            
        case LocationLeft:
            lineView.frame = CGRectMake(0, 0, 1, self.bounds.size.height);
            break;
            
        case LocationBottom:
            lineView.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
            break;
            
        case LocationRight:
            lineView.frame = CGRectMake(self.bounds.size.width - 1, 0, 1, self.bounds.size.height);
            break;
    }
    
    [self addSubview:lineView];
}

@end

NS_ASSUME_NONNULL_END




