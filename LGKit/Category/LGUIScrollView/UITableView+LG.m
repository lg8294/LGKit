//
//  UITableView+NibCell.m
//  qisuedu
//
//  Created by lg on 15/8/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UITableView+LG.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UITableView (LGCell)

- (void)lg_registerCellWithClass:(Class)cellClass
{
    NSString * cellName = NSStringFromClass([cellClass class]);
    [self registerClass:cellClass forCellReuseIdentifier:cellName];
}

- (void)lg_registerHeaderFooterViewWithClass:(Class)headerFooterViewClass
{
    NSString * HeaderFooterViewName = NSStringFromClass([headerFooterViewClass class]);
    [self registerClass:headerFooterViewClass forHeaderFooterViewReuseIdentifier:HeaderFooterViewName];
}

@end

@implementation UITableView (LGNibCell)

- (void)lg_registerNibCellWithClass:(Class)cellClass
{
    NSString * cellName = NSStringFromClass([cellClass class]);
    [self registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle bundleWithIdentifier:cellName]] forCellReuseIdentifier:cellName];
}

- (void)lg_registerNibHeaderFooterViewWithClass:(Class)headerFooterViewClass
{
    NSString * HeaderFooterViewName = NSStringFromClass([headerFooterViewClass class]);
    [self registerNib:[UINib nibWithNibName:HeaderFooterViewName bundle:[NSBundle bundleWithIdentifier:HeaderFooterViewName]] forHeaderFooterViewReuseIdentifier:HeaderFooterViewName];
}

@end

@implementation UITableView (Other)

- (nullable __kindof UITableViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass
{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass([cellClass class])];
}

- (nullable __kindof UITableViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath];
}

- (nullable __kindof UITableViewHeaderFooterView *)lg_dequeueReusableHeaderFooterViewWithClass:(Class)headerFooterViewClass
{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([headerFooterViewClass class])];
}

@end

@implementation UITableView (LGGroupType)

- (void)lg_setTableHeaderView:(nullable UIView *)tableHeaderView {
    if (self.style == UITableViewStyleGrouped && tableHeaderView.bounds.size.height == 0) {
        CGRect bounds = tableHeaderView.bounds;
        bounds.size.height = 0.01;
        tableHeaderView.bounds = bounds;
        [self setTableHeaderView:tableHeaderView];
    } else {
        [self setTableHeaderView:tableHeaderView];
    }
}

- (void)lg_setTableFooterView:(nullable UIView *)tableFooterView {
    if (self.style == UITableViewStyleGrouped && tableFooterView.bounds.size.height == 0) {
        CGRect bounds = tableFooterView.bounds;
        bounds.size.height = 0.01;
        tableFooterView.bounds = bounds;
        [self setTableFooterView:tableFooterView];
    } else {
        [self setTableFooterView:tableFooterView];
    }
}

@end
NS_ASSUME_NONNULL_END

