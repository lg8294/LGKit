//
//  UITextView+LG.m
//  AHCResidentClient
//
//  Created by 李刚 on 16/6/23.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "UITextView+LG.h"
#import <objc/runtime.h>

@implementation UITextView (LG)

#pragma mark - lg_placeholder
- (void)setLg_placeholder:(NSString *)lg_placeholder {
    objc_setAssociatedObject(self, _cmd, lg_placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self.lg_placeholderLabel setText:lg_placeholder];
    [self.lg_placeholderLabel sizeToFit];
}

- (NSString *)lg_placeholder {
    return objc_getAssociatedObject(self, @selector(setLg_placeholder:));
}
#pragma mark - lg_placeholder
- (void)setLg_attributedPlaceholder:(NSAttributedString *)lg_attributedPlaceholder {
    objc_setAssociatedObject(self, _cmd, lg_attributedPlaceholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.lg_placeholderLabel setAttributedText:lg_attributedPlaceholder];
    [self.lg_placeholderLabel sizeToFit];
}

- (NSAttributedString *)lg_attributedPlaceholder {
    return objc_getAssociatedObject(self, @selector(setLg_attributedPlaceholder:));
}

#pragma mark - lg_placeholderLabel
- (UILabel *)lg_placeholderLabel {
    UILabel * label = objc_getAssociatedObject(self, _cmd);
    if (!label) {
        label = [UILabel new];
        [label setNumberOfLines:0];
        [label setTextColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [label setFont:self.font];
        
        objc_setAssociatedObject(self, _cmd, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (object == self) {
        if ([keyPath isEqualToString:@"text"]) {
            [self.lg_placeholderLabel setHidden:(self.text.length > 0)];
        } else if ([keyPath isEqualToString:@"font"]) {
            [self.lg_placeholderLabel setFont:self.font];
        }
    }
}

- (void)receiveTextDidChange:(NSNotification *)notification {
    NSLog(@"%@", notification);
    UITextView * textView = [notification object];
    [textView.lg_placeholderLabel setHidden:(textView.text.length > 0)];
}

//- (void)dealloc {
//    //    NSLog(@"textView dealloc");
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self removeObserver:self forKeyPath:@"text"];
//    [self removeObserver:self forKeyPath:@"font"];
//}

@end
