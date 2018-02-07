//
//  UICollectionView+LGNibCell.h
//  GuiTuHotel
//
//  Created by lg on 16/3/2.
//  Copyright © 2016年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UICollectionView (LGCell)

- (void)lg_registerCellWithClass:(Class)cellClass;
- (void)lg_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind;

@end

@interface UICollectionView (LGNibCell)

/**
 *  注册一个nib类型的cell,reuseIdentifier为cell的类名
 *
 *  @param cellClass cell类
 */
- (void)lg_registerNibCellWithClass:(Class)cellClass;
- (void)lg_registerNibClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind;


@end

@interface UICollectionView (LGOther)

- (nullable __kindof UICollectionViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
