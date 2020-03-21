//
//  PIXPhotoDownloadItem.m
//  Photon
//
//  Created by lg on 2019/12/17.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import "PIXPhotoDownloadItem.h"

@implementation PIXPhotoDownloadItem

- (NSString *)downloadAlertItem_imageUrl {
    if (self.photoItem) {
        if (self.photoItem.photoBiglUrl.length > 0) {
            return self.photoItem.photoBiglUrl;
        }
        if (self.photoItem.photoMiddlelUrl.length > 0) {
            return self.photoItem.photoMiddlelUrl;
        }
        if (self.photoItem.photoSmallUrl.length > 0) {
            return self.photoItem.photoSmallUrl;
        }
    }
    return @"";
}

- (NSString *)downloadAlertItem_headPortraitUrl {
    if (self.photoListItem) {
        return self.photoListItem.headerUrl;
    }
    return @"";
}

- (NSString *)downloadAlertItem_nickName {
    if (self.photoListItem) {
        return self.photoListItem.nickName;
    }
    return @"";
}

- (PIXDownloadAlertType)downloadAlertItem_type {
    PIXDownloadAlertType atype = PIXDownloadAlertTypeUnopen;
    switch (self.type) {
        case PIXWallpaperEnableTypeUnopen:
            atype = PIXDownloadAlertTypeUnopen;
            break;
        case PIXWallpaperEnableTypeUnpayAndLackOfBalance:
            atype = PIXDownloadAlertTypeUnexceptionalAndLeakOfBalance;
            break;
        case PIXWallpaperEnableTypeUnpayAndEnoughOfBalance:
            atype = PIXDownloadAlertTypeUnexceptional;
            break;
        case PIXWallpaperEnableTypePaid:
            atype = PIXDownloadAlertTypeDefault;
            break;
    }
    return atype;
}
@end
