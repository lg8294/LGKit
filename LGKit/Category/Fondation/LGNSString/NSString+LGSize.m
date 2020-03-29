//
//  NSString+Size.m
//  动态计算UITableViewCell高度详解
//
//  Created by apple on 15/6/17.
//  Copyright (c) 2015年 qisu. All rights reserved.
//

#import "NSString+LGSize.h"

NS_ASSUME_NONNULL_BEGIN
@implementation NSString (LGSize)

- (CGSize)lg_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize expectedLabelSize = CGSizeZero;
    
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    NSMutableParagraphStyle * paragraphStype = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStype setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    paragraphStype.lineBreakMode = lineBreakMode;
//    alignment //对齐方式
//    firstLineHeadIndent //首行缩进
//    headIndent //缩进
//    tailIndent //尾部缩进
//    lineBreakMode //断行方式
//    maximumLineHeight //最大行高
//    minimumLineHeight //最低行高
//    lineSpacing //行距
//    paragraphSpacing //段距
//    paragraphSpacingBefore //段首空间
//    baseWritingDirection //句子方向
//    lineHeightMultiple //可变行高,乘因数。
//    hyphenationFactor //连字符属性
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStype};
    
    expectedLabelSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attributes
                                           context:nil
                         ].size;

#else //iOS6
    expectedLabelSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#endif
    return expectedLabelSize;
}

- (CGSize)lg_boundingCeilSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    CGSize expectedLabelSize = [self lg_boundingSizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
    
    if ([UIScreen mainScreen].scale > 1) {
        float widthInt,heightInt;
        CGFloat widthDecimal,heightDecimal;
        
        widthDecimal = modff(expectedLabelSize.width, &widthInt);
        heightDecimal = modff(expectedLabelSize.height, &heightInt);
        
        CGFloat scale = [UIScreen mainScreen].scale;
        
        for (int i = 1; i <= scale; i++) {
            CGFloat temp = i/scale;
            if (widthDecimal < temp) {
                widthDecimal = temp;
                break;
            }
        }
        
        for (int i = 1; i <= scale; i++) {
            CGFloat temp = i/scale;
            if (heightDecimal < temp) {
                heightDecimal = temp;
                break;
            }
        }
        
        return CGSizeMake(widthInt+widthDecimal, heightInt+heightDecimal);
    } else {
        //ceil(value) 返回不小于 value 的下一个整数，value 如果有小数部分则进一位。
        return CGSizeMake(ceilf(expectedLabelSize.width), expectedLabelSize.width == 0 ? 0 : ceilf(expectedLabelSize.height));
    }
}

@end

@implementation NSAttributedString (LGSize)

- (CGSize)lg_boundingSizeWithConstrainedToSize:(CGSize)size {
    CGSize expectedLabelSize = CGSizeZero;

    expectedLabelSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                           context:nil
                         ].size;
    
    return expectedLabelSize;
}

- (CGSize)lg_boundingCeilSizeWithConstrainedToSize:(CGSize)size {
    
    CGSize expectedLabelSize = [self lg_boundingSizeWithConstrainedToSize:size];
    
    if ([UIScreen mainScreen].scale > 1) {
        float widthInt,heightInt;
        CGFloat widthDecimal,heightDecimal;
        
        widthDecimal = modff(expectedLabelSize.width, &widthInt);
        heightDecimal = modff(expectedLabelSize.height, &heightInt);
        
        CGFloat scale = [UIScreen mainScreen].scale;
        
        for (int i = 1; i <= scale; i++) {
            CGFloat temp = i/scale;
            if (widthDecimal < temp) {
                widthDecimal = temp;
                break;
            }
        }
        
        for (int i = 1; i <= scale; i++) {
            CGFloat temp = i/scale;
            if (heightDecimal < temp) {
                heightDecimal = temp;
                break;
            }
        }
        
        return CGSizeMake(widthInt+widthDecimal, heightInt+heightDecimal);
    } else {
        //ceil(value) 返回不小于 value 的下一个整数，value 如果有小数部分则进一位。
        return CGSizeMake(ceilf(expectedLabelSize.width), expectedLabelSize.width == 0 ? 0 : ceilf(expectedLabelSize.height));
    }
}

@end
NS_ASSUME_NONNULL_END


