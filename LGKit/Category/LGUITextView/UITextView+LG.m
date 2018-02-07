//
//  UITextView+LG.m
//  AHCResidentClient
//
//  Created by 李刚 on 16/6/23.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "UITextView+LG.h"
#import <objc/runtime.h>

static char PlaceholderKey;
static char AttributedPlaceholderKey;
static char PlaceholderLabelKey;

@implementation UITextView (LG)

#pragma mark - runtime

- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &PlaceholderKey, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[self getPlaceholderLabel] setText:placeholder];
    [[self getPlaceholderLabel] sizeToFit];
}

- (NSString *)getPlaceholder {
    return objc_getAssociatedObject(self, &PlaceholderKey);
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    objc_setAssociatedObject(self, &AttributedPlaceholderKey, attributedPlaceholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [[self getPlaceholderLabel] setAttributedText:attributedPlaceholder];
    [[self getPlaceholderLabel] sizeToFit];
}

- (NSAttributedString *)getAttributedPlaceholder {
    return objc_getAssociatedObject(self, &AttributedPlaceholderKey);
}

//- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
//    objc_setAssociatedObject(self, &PlaceholderLabelKey, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (UILabel *)getPlaceholderLabel {
    UILabel * label = objc_getAssociatedObject(self, &PlaceholderLabelKey);
    if (!label) {
        label = [UILabel new];
        [label setNumberOfLines:0];
        [label setTextColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [label setFont:self.font];
        
        objc_setAssociatedObject(self, &PlaceholderLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:label];
        
        
        label.translatesAutoresizingMaskIntoConstraints=NO;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[label]-5-|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(label)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[label]-(>=8)-|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(label)]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    }
    return label;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (object == self) {
        if ([keyPath isEqualToString:@"text"]) {
            [[self getPlaceholderLabel] setHidden:(self.text.length > 0)];
        } else if ([keyPath isEqualToString:@"font"]) {
            [[self getPlaceholderLabel] setFont:self.font];
        }
    }
}
- (void)receiveTextDidChange:(NSNotification *)notification {
    //NSLog(@"%@", notification);
    UITextView * textView = [notification object];
    [[textView getPlaceholderLabel] setHidden:(textView.text.length > 0)];
}

- (void)dealloc {
    //    NSLog(@"textView dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"text"];
    [self removeObserver:self forKeyPath:@"font"];
}

@end
