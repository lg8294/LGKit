//
//  UITextField+PlaceholderLabel.m
//  Photon
//
//  Created by lg on 25/10/2019.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import "UITextField+PlaceholderLabel.h"

@implementation UITextField (PlaceholderLabel)

- (void)setPlaceholderLabelTextColor:(UIColor *)placeholderTextColor {
    if (@available(iOS 13, *)) {
        [self setValue:placeholderTextColor forKeyPath:@"placeholderLabel.textColor"];
    } else {
        [self setValue:placeholderTextColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}
- (UIColor *)placeholderLabelTextColor {
    if (@available(iOS 13, *)) {
        return [self valueForKeyPath:@"placeholderLabel.textColor"];
    } else {
        return [self valueForKeyPath:@"_placeholderLabel.textColor"];
    }
    return nil;
}

- (void)setPlaceholderLabelTextFont:(UIFont *)placeholderTextFont {
    if (@available(iOS 13, *)) {
        [self setValue:placeholderTextFont forKeyPath:@"placeholderLabel.font"];
    } else {
        [self setValue:placeholderTextFont forKeyPath:@"_placeholderLabel.font"];
    }
}
- (UIFont *)placeholderLabelTextFont {
    if (@available(iOS 13, *)) {
        return [self valueForKeyPath:@"placeholderLabel.font"];
    } else {
        return [self valueForKeyPath:@"_placeholderLabel.font"];
    }
    return nil;
}

- (void)setPlaceholderLabelAlpha:(NSNumber *)placeholderLabelAlpha {
    if (@available(iOS 13, *)) {
        [self setValue:placeholderLabelAlpha forKeyPath:@"placeholderLabel.alpha"];
    } else {
        [self setValue:placeholderLabelAlpha forKeyPath:@"_placeholderLabel.alpha"];
    }
}
- (NSNumber *)placeholderLabelAlpha {
    if (@available(iOS 13, *)) {
        return [self valueForKeyPath:@"placeholderLabel.alpha"];
    } else {
        return [self valueForKeyPath:@"_placeholderLabel.alpha"];
    }
    return nil;
}
@end
