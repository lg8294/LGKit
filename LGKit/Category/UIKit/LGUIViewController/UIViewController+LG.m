//
//  UIViewController+UINib.m
//  qisuedu
//
//  Created by lg on 15/8/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIViewController+LG.h"

@implementation UIViewController (LG)
+ (instancetype)lg_viewControllerFromNib
{
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
