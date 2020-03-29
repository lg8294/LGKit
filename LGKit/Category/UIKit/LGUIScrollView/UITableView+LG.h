//
//  UITableView+NibCell.h
//  qisuedu
//
//  Created by lg on 15/8/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (LGBase)
@end

@interface UITableView (LGDequeueReusable)

- (nullable __kindof UITableViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass;
- (nullable __kindof UITableViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;
- (nullable __kindof UITableViewHeaderFooterView *)lg_dequeueReusableHeaderFooterViewWithClass:(Class)headerFooterViewClass;

@end

@interface UITableView (LGGroupType)

@property (nonatomic, nullable, getter=tableHeaderView) UIView * lg_tableHeaderView;
@property (nonatomic, nullable, getter=tableFooterView) UIView * lg_tableFooterView;

@end

NS_ASSUME_NONNULL_END
