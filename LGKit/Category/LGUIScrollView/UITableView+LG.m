//
//  UITableView+NibCell.m
//  qisuedu
//
//  Created by lg on 15/8/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UITableView+LG.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@implementation UITableView (LGBase)

#pragma mark - 复用 cell
- (NSMutableSet<NSString *> *)lg_reusableCellIdentifier {
    NSMutableSet<NSString *> *set = objc_getAssociatedObject(self, _cmd);
    if (set == nil) {
        set = NSMutableSet.new;
        objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return set;
}

- (NSString *)lg_reuseIdentifierForCellClass:(Class)cellClass {
    NSString *identifier = NSStringFromClass(cellClass);
    if (![self.lg_reusableCellIdentifier containsObject:identifier]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
        if (path) {
            [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
        } else {
            [self registerClass:cellClass forCellReuseIdentifier:identifier];
        }
        [self.lg_reusableCellIdentifier addObject:identifier];
    }
    return identifier;
}

#pragma mark - 复用 头部和底部
- (NSMutableSet<NSString*> *)lg_reuseableHeaderOrFooterIdentifier {
    NSMutableSet<NSString *> *set = objc_getAssociatedObject(self, _cmd);
    if (set == nil) {
        set = NSMutableSet.new;
        objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return set;
}

- (NSString *)lg_reuseIdentifierForHeaderOrFooterClass:(Class)headerOrFooterClass {
    NSString *identifier = NSStringFromClass(headerOrFooterClass);
    if (![[self lg_reuseableHeaderOrFooterIdentifier] containsObject:identifier]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
        if (path) {
            [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
        } else {
            [self registerClass:headerOrFooterClass forHeaderFooterViewReuseIdentifier:identifier];
        }
        [[self lg_reuseableHeaderOrFooterIdentifier] addObject:identifier];
    }
    return identifier;
}

@end

@implementation UITableView (LGCell)

- (void)lg_registerCellWithClass:(Class)cellClass
{
    NSString * cellName = NSStringFromClass([cellClass class]);
    if (![[self lg_reusableCellIdentifier] containsObject:cellName]) {
        [self registerClass:cellClass forCellReuseIdentifier:cellName];
        [[self lg_reusableCellIdentifier] addObject:cellName];
    }
}

- (void)lg_registerHeaderFooterViewWithClass:(Class)headerFooterViewClass
{
    NSString * HeaderFooterViewName = NSStringFromClass([headerFooterViewClass class]);
    if (![[self lg_reuseableHeaderOrFooterIdentifier] containsObject:HeaderFooterViewName]) {
        [self registerClass:headerFooterViewClass forHeaderFooterViewReuseIdentifier:HeaderFooterViewName];
        [[self lg_reuseableHeaderOrFooterIdentifier] addObject:HeaderFooterViewName];
    }
}

@end

@implementation UITableView (LGNibCell)

- (void)lg_registerNibCellWithClass:(Class)cellClass
{
    NSString * cellName = NSStringFromClass([cellClass class]);
    if (![[self lg_reusableCellIdentifier] containsObject:cellName]) {
        [self registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle bundleWithIdentifier:cellName]] forCellReuseIdentifier:cellName];
        [[self lg_reusableCellIdentifier] addObject:cellName];
    }
}

- (void)lg_registerNibHeaderFooterViewWithClass:(Class)headerFooterViewClass
{
    NSString * HeaderFooterViewName = NSStringFromClass([headerFooterViewClass class]);
    if (![[self lg_reuseableHeaderOrFooterIdentifier] containsObject:HeaderFooterViewName]) {
        [self registerNib:[UINib nibWithNibName:HeaderFooterViewName bundle:[NSBundle bundleWithIdentifier:HeaderFooterViewName]] forHeaderFooterViewReuseIdentifier:HeaderFooterViewName];
        [[self lg_reuseableHeaderOrFooterIdentifier] addObject:HeaderFooterViewName];
    }
}

@end

@implementation UITableView (Other)

- (nullable __kindof UITableViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass
{
    return [self dequeueReusableCellWithIdentifier:[self lg_reuseIdentifierForCellClass:cellClass]];
}

- (nullable __kindof UITableViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithIdentifier:[self lg_reuseIdentifierForCellClass:cellClass] forIndexPath:indexPath];
}

- (nullable __kindof UITableViewHeaderFooterView *)lg_dequeueReusableHeaderFooterViewWithClass:(Class)headerFooterViewClass
{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:[self lg_reuseIdentifierForHeaderOrFooterClass:headerFooterViewClass]];
}

@end

@implementation UITableView (LGGroupType)

- (void)setLg_tableHeaderView:(nullable UIView *)lg_tableHeaderView {
    if (self.style == UITableViewStyleGrouped && lg_tableHeaderView.bounds.size.height == 0) {
        CGRect bounds = lg_tableHeaderView.bounds;
        bounds.size.height = 0.01;
        lg_tableHeaderView.bounds = bounds;
        [self setTableHeaderView:lg_tableHeaderView];
    } else {
        [self setTableHeaderView:lg_tableHeaderView];
    }
}

- (void)setLg_tableFooterView:(nullable UIView *)lg_tableFooterView {
    if (self.style == UITableViewStyleGrouped && lg_tableFooterView.bounds.size.height == 0) {
        CGRect bounds = lg_tableFooterView.bounds;
        bounds.size.height = 0.01;
        lg_tableFooterView.bounds = bounds;
        [self setTableFooterView:lg_tableFooterView];
    } else {
        [self setTableFooterView:lg_tableFooterView];
    }
}

@end
NS_ASSUME_NONNULL_END

