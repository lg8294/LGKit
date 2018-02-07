//
//  UICollectionView+LGNibCell.m
//  GuiTuHotel
//
//  Created by lg on 16/3/2.
//  Copyright © 2016年 PJ. All rights reserved.
//

#import "UICollectionView+LG.h"

//- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
//- (void)registerNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
//
//- (void)registerClass:(nullable Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier;
//- (void)registerNib:(nullable UINib *)nib forSupplementaryViewOfKind:(NSString *)kind withReuseIdentifier:(NSString *)identifier;
//
//- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
//- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;


NS_ASSUME_NONNULL_BEGIN
@implementation UICollectionView (LGCell)

- (void)lg_registerCellWithClass:(Class)cellClass {
    NSString * cellName = NSStringFromClass([cellClass class]);
    [self registerClass:cellClass forCellWithReuseIdentifier:cellName];
}

- (void)lg_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind {
    NSString * viewName = NSStringFromClass([viewClass class]);
    [self registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:viewName];
}


@end

@implementation UICollectionView (LGNibCell)

- (void)lg_registerNibCellWithClass:(Class)cellClass
{
    NSString * cellName = NSStringFromClass([cellClass class]);
    [self registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle bundleWithIdentifier:cellName]] forCellWithReuseIdentifier:cellName];
}

- (void)lg_registerNibClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind {
    NSString * viewName = NSStringFromClass([viewClass class]);
    [self registerNib:[UINib nibWithNibName:viewName bundle:[NSBundle bundleWithIdentifier:viewName]] forSupplementaryViewOfKind:elementKind withReuseIdentifier:viewName];
}

@end

@implementation UICollectionView (LGOther)

- (nullable __kindof UICollectionViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath];
}

- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withClass:(Class)viewClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass([viewClass class]) forIndexPath:indexPath];
}

@end
NS_ASSUME_NONNULL_END


