//
//  UIView+PIXNoDataView.h
//  Photon
//
//  Created by lg on 2019/11/27.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PIXNoDataView)

/// 显示空视图，默认添加到视图上显示
- (void)pix_showEmptyView;

/// 重置空视图
- (void)pix_resetEmptyView;

/// 无数据视图
@property(nonatomic) UIView *pix_noDataView;

/// 无数据视图中的图片名称。默认无。设置了 pix_noDataView 后失效无效
@property(nonatomic) NSString *pix_noDataImageName;

/// 无数据视图中的标题。默认“暂无数据”。设置了 pix_noDataView 后失效无效
@property(nonatomic) NSString *pix_noDataTitle;

/// 无数据视图中的内容文本。默认无。设置了 pix_noDataView 后失效无效
@property(nonatomic) NSString *pix_noDataContent;

@end

NS_ASSUME_NONNULL_END
