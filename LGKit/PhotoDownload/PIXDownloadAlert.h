//
//  PIXDownloadAlert.h
//  Photon
//
//  Created by lg on 2019/12/13.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PIXDownloadAlertType) {
    PIXDownloadAlertTypeUnopen = 0,///<未开放
    PIXDownloadAlertTypeUnexceptionalAndLeakOfBalance,///<未打赏，下载券不足
    PIXDownloadAlertTypeUnexceptional,///<未打赏，下载券充足
    PIXDownloadAlertTypeDefault = 3,///<已打赏，可以下载
};

@protocol PIXDownloadAlertItemProtocol <NSObject>

/// 图片下载地址
@property(nonatomic,readonly) NSString *downloadAlertItem_imageUrl;

/// 用户头像
@property(nonatomic,readonly) NSString *downloadAlertItem_headPortraitUrl;

/// 用户昵称
@property(nonatomic,readonly) NSString *downloadAlertItem_nickName;

/// 下载提示类型
@property(nonatomic) PIXDownloadAlertType downloadAlertItem_type;

@end

@protocol PIXDownloadAlertDelegate;

@interface PIXDownloadAlert : UIView

@property(nonatomic) UIView *contentView;
@property(nonatomic) UIImageView *iconImageView;
@property(nonatomic) UILabel *nicknameLabelView;
@property(nonatomic) UILabel *tipLabel;
@property(nonatomic) UIButton *actionBtn;
@property(nonatomic) UILabel *bottomLabel;
@property(nonatomic) UIButton *closeBtn;

/// 展示下载提示
/// @param item 下载源数据
+ (PIXDownloadAlert *)showWithDownloadAlertItem:(id<PIXDownloadAlertItemProtocol>)item;

/// 展示
/// @param item item description
/// @param animated animated description
- (void)showAlertWithDownloadAlertItem:(id<PIXDownloadAlertItemProtocol>)item animated:(BOOL)animated;

/// 隐藏 Alert
- (void)hideAlert;

/// 移除
- (void)dismiss;

@property(nonatomic,weak) id<PIXDownloadAlertDelegate> delegate;

/// 下载完成回调
@property(nonatomic) void(^downloadBlock)(void);

@end


@protocol PIXDownloadAlertDelegate <NSObject>

- (void)downloadAlert:(PIXDownloadAlert *)alert clickActionType:(PIXDownloadAlertType)type;

@end
NS_ASSUME_NONNULL_END
