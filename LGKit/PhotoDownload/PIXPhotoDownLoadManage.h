//
//  PIXPhotoDownLoadManage.h
//  Photon
//
//  Created by lg on 2019/12/17.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIXPhotoListItem.h"
#import "PIXPhotoItem.h"
#import "PIXDownloadAlert.h"
#import "PIXPhotoDownloadItem.h"
#import "PIXWallpaperRequestService.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PIXWallpaperDownLoadManageBlock)(BOOL success,  NSString * _Nullable errorCode);

@interface PIXPhotoDownLoadManage : NSObject<PIXDownloadAlertDelegate>

+ (instancetype)shareInstance;

@property(nonatomic) PIXDownloadAlert *view;

/// 当前下载图片的用户信息包含在这里，必需
@property(nonatomic) PIXPhotoListItem *currentPhotoListItem;

/// 当前要下载的图片，必需
@property(nonatomic) PIXPhotoItem *currentPhotoItem;

@property(nonatomic) PIXWallpaperRequestService *wallpaperService;

- (void)getWallpaperEnnableWithPhoneUrl:(nullable NSString *)photoUrl complate:(void(^)(BOOL success, NSString * _Nullable errorCode, PIXWallpaperEnableType type))complate;

- (void)downloadImageWithUrl:(nullable NSURL *)url progress:(void(^)(CGFloat progress))progress complate:(PIXWallpaperDownLoadManageBlock)complate;

/// 显示下载提示
- (void)showDownloadAlert;

/// 去充值前的处理
@property(nonatomic,copy) void(^willToRechargeBlock)(void);

/// 去登录前的处理
@property(nonatomic,copy) UIViewController<PIXLoginAndRegisterDelegate>*(^willToLoginBlock)(void);

@end

/// 埋点统计
@interface PIXPhotoDownLoadManage ()

/// 0：壁纸，1：其他模块
@property (nonatomic) NSInteger analytic_location;

/// A（下载券不够弹窗点击。弹窗展示），B（消耗XX下载券弹窗展示）
//@property(nonatomic,copy) NSString *analytic_type;

@end

NS_ASSUME_NONNULL_END
