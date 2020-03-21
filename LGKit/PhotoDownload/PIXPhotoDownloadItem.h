//
//  PIXPhotoDownloadItem.h
//  Photon
//
//  Created by lg on 2019/12/17.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIXDownloadAlert.h"
#import "PIXPhotoItem.h"
#import "PIXPhotoListItem.h"

NS_ASSUME_NONNULL_BEGIN

//0作者未开启壁纸售卖开关 1开关开启未支付无足够余额 2开关开启未支付有足够余额 3已支付
typedef NS_ENUM(NSUInteger, PIXWallpaperEnableType) {
    PIXWallpaperEnableTypeUnopen = 0,///< 作者未开启壁纸售卖开关
    PIXWallpaperEnableTypeUnpayAndLackOfBalance,///< 开关开启未支付无足够余额
    PIXWallpaperEnableTypeUnpayAndEnoughOfBalance,///< 开关开启未支付有足够余额
    PIXWallpaperEnableTypePaid///< 已支付
};

@interface PIXPhotoDownloadItem : NSObject<PIXDownloadAlertItemProtocol>

@property(nonatomic) PIXPhotoItem *photoItem;
@property(nonatomic) PIXPhotoListItem *photoListItem;
@property(nonatomic) PIXWallpaperEnableType type;

@property(nonatomic) PIXDownloadAlertType downloadAlertItem_type;

@end

NS_ASSUME_NONNULL_END
