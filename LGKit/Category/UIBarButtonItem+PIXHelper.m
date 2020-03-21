//
//  UIBarButtonItem+PIXHelper.m
//  Photon
//
//  Created by lg on 2020/2/11.
//  Copyright © 2020 everimaging. All rights reserved.
//

#import "UIBarButtonItem+PIXHelper.h"
#import "PIXNavigationBarItemView.h"

@implementation UIBarButtonItem (PIXHelper)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (@available(iOS 11.0, *)) {
        // iOS 11 之后，默认就是 44*44
    } else {
        // iOS 11 之前，需要指定尺寸
        [btn setFrame:CGRectMake(0, 0, 44, 44)];
    }
    
    UIBarButtonItem *item = [[self alloc] initWithCustomView:btn];
    
    return item;
}

+ (UIBarButtonItem *)itemWithImageNames:(NSArray<NSString *> *)imageNames target:(id)target action:(SEL)action {
    
    PIXNavigationBarItemView *itemView = [[PIXNavigationBarItemView alloc] initWithUseSubViewSize:NO];
    [imageNames enumerateObjectsUsingBlock:^(NSString * _Nonnull imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.tag = idx;
        
        [itemView addSubview:btn];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    return item;
}
@end
