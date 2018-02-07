//
//  UITextView+LG.h
//  AHCResidentClient
//
//  Created by 李刚 on 16/6/23.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LG)

- (void)setPlaceholder:(NSString *)placeholder;
- (NSString *)getPlaceholder;

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder;
- (NSAttributedString *)getAttributedPlaceholder;

- (UILabel *)getPlaceholderLabel;

@end
