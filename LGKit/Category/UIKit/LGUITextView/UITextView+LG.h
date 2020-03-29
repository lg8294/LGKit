//
//  UITextView+LG.h
//  AHCResidentClient
//
//  Created by 李刚 on 16/6/23.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LG)

@property(nonatomic) NSString *lg_placeholder;

@property(nonatomic) NSAttributedString *lg_attributedPlaceholder;

@property(nonatomic,readonly) UILabel *lg_placeholderLabel;

@end
