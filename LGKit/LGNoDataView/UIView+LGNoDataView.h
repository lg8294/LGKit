//
//  UIView+LGNoDataView.h
//
//  Created by lg on 2019/11/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LGNoDataView)

/// 显示空视图，默认添加到视图上显示
- (void)lg_showNoDataView;

/// 重置空视图
- (void)lg_resetNoDataView;

/// 无数据视图
@property(nonatomic) UIView *lg_noDataView;

/// 无数据视图中的图片名称。默认无。设置了 lg_noDataView 后失效无效
@property(nonatomic) NSString *lg_noDataImageName;

/// 无数据视图中的标题。默认“暂无数据”。设置了 lg_noDataView 后失效无效
@property(nonatomic) NSString *lg_noDataTitle;

/// 无数据视图中的内容文本。默认无。设置了 lg_noDataView 后失效无效
@property(nonatomic) NSString *lg_noDataContent;

@end

NS_ASSUME_NONNULL_END
