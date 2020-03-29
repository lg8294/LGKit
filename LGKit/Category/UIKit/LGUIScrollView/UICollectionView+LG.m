//
//  UICollectionView+LGNibCell.m
//  GuiTuHotel
//
//  Created by lg on 16/3/2.
//  Copyright © 2016年 PJ. All rights reserved.
//

#import "UICollectionView+LG.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN
@implementation UICollectionView (LGBase)

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
            [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
        } else {
            [self registerClass:cellClass forCellWithReuseIdentifier:identifier];
        }
        [self.lg_reusableCellIdentifier addObject:identifier];
    }
    return identifier;
}

#pragma mark - 复用 Header
/// 复用 header
- (NSMutableSet<NSString *> *)lg_reusableHeaderIdentifier {
    NSMutableSet<NSString *> *set = objc_getAssociatedObject(self, _cmd);
    if (set == nil) {
        set = NSMutableSet.new;
        objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return set;
}

/// 通过类名获取复用 ID，如果没有注册类，自动注册
/// @param headerClass 头部视图类
- (NSString *)lg_reuseIdentifierForHeaderClass:(Class)headerClass {
    NSString *identifier = NSStringFromClass(headerClass);
    if (![self.lg_reusableHeaderIdentifier containsObject:identifier]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
        if (path) {
            [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        } else {
            [self registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        }
        [self.lg_reusableHeaderIdentifier addObject:identifier];
    }
    return identifier;
}

#pragma mark - 复用 Footer
/// 复用 footer
- (NSMutableSet<NSString *> *)lg_reusableFooterIdentifier {
    NSMutableSet<NSString *> *set = objc_getAssociatedObject(self, _cmd);
    if (set == nil) {
        set = NSMutableSet.new;
        objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return set;
}

/// 通过类名获取复用 ID，如果没有注册类，自动注册
/// @param footerClass 头部视图类
- (NSString *)lg_reuseIdentifierForFooterClass:(Class)footerClass {
    NSString *identifier = NSStringFromClass(footerClass);
    if (![self.lg_reusableFooterIdentifier containsObject:identifier]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
        if (path) {
            [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        } else {
            [self registerClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        }
        [self.lg_reusableFooterIdentifier addObject:identifier];
    }
    return identifier;
}

@end

@implementation UICollectionView (LGDequeueReusable)

- (nullable __kindof UICollectionViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:[self lg_reuseIdentifierForCellClass:cellClass] forIndexPath:indexPath];
}

- (nullable __kindof UICollectionReusableView *)lg_dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withClass:(Class)viewClass forIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier=@"";
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        identifier = [self lg_reuseIdentifierForHeaderClass:viewClass];
    }
    else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        identifier = [self lg_reuseIdentifierForFooterClass:viewClass];
    }
    return [self dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
NS_ASSUME_NONNULL_END


