//
//  PIXPhotoDownLoadManage.m
//  Photon
//
//  Created by lg on 2019/12/17.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import "PIXPhotoDownLoadManage.h"
#import "PIXPhotoAlbumManage.h"
#import "PIXPhotoDownloadItem.h"
#import "PHPersonalService.h"
#import <Photos/Photos.h>
#import "AppDelegate.h"
#import "PIXWallpaperRechargeViewController.h"

@interface PIXPhotoDownLoadManage ()

@property(nonatomic) PHPersonalService *personalService;

@property(nonatomic) UIActivityIndicatorView *activityIndicator;
@property(nonatomic) UILabel *progressLabel;

@property(nonatomic) PIXPhotoDownloadItem *currentDownloadItem;

@end

@implementation PIXPhotoDownLoadManage

+ (instancetype)shareInstance {
    static PIXPhotoDownLoadManage *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = PIXPhotoDownLoadManage.new;
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wallpaperService = PIXWallpaperRequestService.new;
        _personalService = PHPersonalService.new;
    }
    return self;
}

- (void)resetViewState {
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator setCenter:self.view.center];
    [self.view addSubview:self.progressLabel];
    [self.progressLabel setCenter:self.view.center];
    
    [self.view hideAlert];
    [self hideProgress];
    [self stopLoadingAnimation];
}
#pragma mark - Public

- (void)showDownloadAlert {
    
    [self resetViewState];
    
    UIWindow *w = [UIApplication sharedApplication].keyWindow;
    [w addSubview:self.view];
    
    self.currentDownloadItem = PIXPhotoDownloadItem.new;
    self.currentDownloadItem.photoItem = self.currentPhotoItem;
    self.currentDownloadItem.photoListItem = self.currentPhotoListItem;
    
    lg_weakSelf;
    
    [self startLoadingAnimation];
    [self getWallpaperEnnableWithPhoneUrl:nil complate:^(BOOL success, NSString * _Nullable errorCode, PIXWallpaperEnableType type) {
        [weakSelf stopLoadingAnimation];
        if (success) {
            weakSelf.currentDownloadItem.type = type;
            
            [weakSelf analyticShow];
            [weakSelf.view showAlertWithDownloadAlertItem:weakSelf.currentDownloadItem animated:NO];
        } else {
            if ([EIServerRespCode isTokenInvalid:errorCode]) {
                UIViewController<PIXLoginAndRegisterDelegate> *vc;
                if (weakSelf.willToLoginBlock) {
                    vc = weakSelf.willToLoginBlock();
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                    [PIXSessionHelper sessionExpired:^(BOOL isOk) {
                        if (!isOk) {
                        }
                    } expireToken:[PIXUserSession tryToGetAccessToken] parentController:vc shouldLogin:YES];
                });
            }
            else {
                [PhotonTipView showNetworkError];
            }
            [weakSelf dismiss];
        }
    }];
}

- (void)dismiss {
    [self.view dismiss];
}

#pragma mark - API
- (void)getWallpaperEnnableWithPhoneUrl:(nullable NSString *)photoUrl complate:(void (^)(BOOL, NSString * _Nullable, PIXWallpaperEnableType))complate {
    
    if (photoUrl == nil) {
        photoUrl = self.currentPhotoItem.photoUrl;
    }
    NSAssert(self.currentPhotoListItem.author != nil, @"author 不能为空");
    NSAssert(self.currentPhotoListItem.permlink != nil, @"permlink 不能为空");
    NSAssert(photoUrl != nil, @"photoUrl 不能为空");
    
    NSDictionary *params = @{@"author":self.currentPhotoListItem.author,@"permlink":self.currentPhotoListItem.permlink,@"photoUrl":photoUrl};
    [self.wallpaperService requestWallpaperEnable:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSInteger code = [responseObject integerValue];
        if (complate) {
            complate(YES,nil,code);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorCode) {
        if (complate) {
            complate(NO,errorCode,0);
        }
    }];
}

// 下载壁纸，并保存到相册中
- (void)downloadImageWithUrl:(NSURL *)url progress:(void (^)(CGFloat))progress complate:(PIXWallpaperDownLoadManageBlock)complate {
    
    if (url == nil) {
        url = [self.class getUrlFromPhotoItem:self.currentDownloadItem.photoItem];
    }
    
    NSAssert(url != nil, @"url 不能为空");
    
    CGFloat min = 0.05;
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        CGFloat rate = (CGFloat)receivedSize/expectedSize;
        rate = MAX(min, rate);
        NSLog(@"下载进度%f", rate);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(rate);
            }
        });
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (!error && finished) {
            [PIXPhotoAlbumManage saveImage:image complate:^(BOOL success, NSString * _Nonnull errorMsg) {

                NSString *msg = nil ;
                if(!success){
                    msg = errorMsg;
                }else{
                    msg = @"感谢您的支持，作品已成功保存到您的相册";
                }
                if (complate) {
                    complate(success,msg);
                }
            }];
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                complate(NO,error.localizedFailureReason);
            });
        }
    }];
}

#pragma mark - PIXDownloadAlertDelegate
- (void)downloadAlert:(PIXDownloadAlert *)alert clickActionType:(PIXDownloadAlertType)type {
    [self analyticClick];
    switch (type) {
        case PIXDownloadAlertTypeDefault: {
            // 开始下载
            [self downloadImageAndAuthorization];
        }
            break;
        case PIXDownloadAlertTypeUnexceptional:{
            // 去打赏
            [self exceptional];
        }
            break;
        case PIXDownloadAlertTypeUnexceptionalAndLeakOfBalance: {
            // 去充值
            [self recharge];
        }
            break;
        case PIXDownloadAlertTypeUnopen:{
            // 提醒作者
            [self remindAuthor];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - private
- (void)startLoadingAnimation {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator swStartAnimating];
}

- (void)stopLoadingAnimation {
    self.activityIndicator.hidden = YES;
    [self.activityIndicator swStopAnimating];
}

- (void)showProgress:(CGFloat)progress {
    
    NSString *p = [NSString stringWithFormat:@"%.f %%", progress*100];
    [self.progressLabel setText:p];
    [self.progressLabel setHidden:NO];
    [self.progressLabel sizeToFit];
}

- (void)hideProgress {
    [self.progressLabel setText:nil];
    [self.progressLabel setHidden:YES];
}

- (void)exceptional {
    // 打赏
    NSAssert(self.currentPhotoListItem.author != nil, @"author 不能为空");
    NSAssert(self.currentPhotoListItem.permlink != nil, @"permlink 不能为空");
    NSAssert(self.currentPhotoItem.photoUrl != nil, @"photoUrl 不能为空");
    lg_weakSelf;
    
    [self startLoadingAnimation];
    
    NSDictionary *params = @{@"author":self.currentPhotoListItem.author,@"permlink":self.currentPhotoListItem.permlink,@"photoUrl":self.currentPhotoItem.photoUrl};
    [self.wallpaperService requestWallpaperRedeem:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf stopLoadingAnimation];
        weakSelf.currentDownloadItem.type = PIXWallpaperEnableTypePaid;
        [weakSelf downloadImageAndAuthorization];
    } failure:^(NSURLSessionDataTask *task, NSString *errorCode) {
//        [PhotonTipView showMessage:errorCode];
        if ([errorCode isEqualToString:@"999"]) {
            [PhotonTipView showMessage:NSLocalizedString(@"photoDownload.buyfailure", nil)];
        } else {
            [PhotonTipView showNetworkError];
        }
        [weakSelf stopLoadingAnimation];
        [weakSelf dismiss];
    }];
    
    [self.view hideAlert];
}
- (void)recharge {
    // 去充值
    [self dismiss];
    if (self.willToRechargeBlock) {
        self.willToRechargeBlock();
    }
    
    // 大图预览消失会设置状态栏显示，这里延时 100ms,可以保证 push 动画正常
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        PIXWallpaperRechargeViewController *wallpaperVc = [[PIXWallpaperRechargeViewController alloc] init];
        wallpaperVc.from = kPIXWallpaperRechargeFromWallpaperDownload;
        wallpaperVc.hidesBottomBarWhenPushed = YES;
        [[(AppDelegate *)[UIApplication sharedApplication].delegate topViewController].navigationController pushViewController:wallpaperVc animated:YES];
    });
}
- (void)remindAuthor {
    // 提醒作者
    NSDictionary *params = @{@"author":self.currentDownloadItem.photoListItem.author};
    [self.personalService wallpaperRemindWithParameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [PhotonTipView showMessage:NSLocalizedString(@"photoDownload.remind.success", nil)];
    } failure:^(NSURLSessionDataTask *task, NSString *errorCode) {
        [PhotonTipView showMessage:errorCode];
    }];
    [self dismiss];
}

- (void)downloadImageAndAuthorization {
    
    [self.view hideAlert];
    [self.activityIndicator stopAnimating];
    
    // 检测相册权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [PhotonTipView showMessage:NSLocalizedString(@"photoDownload.noAlumPermission", nil)];
        [self dismiss];
        return;
    }
    
    lg_weakSelf;
    void(^downloadBlock)(void) = ^{
        [weakSelf downloadImage];
    };
    
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            switch (status) {
                case PHAuthorizationStatusAuthorized: {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        downloadBlock();
                    });
                }
                    break;
                default:
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [PhotonTipView showMessage:NSLocalizedString(@"photoDownload.noAlumPermission", nil)];
                        [self dismiss];
                    });
                    break;
            }
        }];
    } else {
        downloadBlock();
    }
}

- (void)downloadImage {
    lg_weakSelf;
    
    PIXPhotoDownloadItem *item = PIXPhotoDownloadItem.new;
    item.photoItem = self.currentPhotoItem;
    item.photoListItem = self.currentPhotoListItem;
    NSURL *url = [NSURL URLWithString:item.downloadAlertItem_imageUrl];
    
    [self downloadImageWithUrl:url progress:^(CGFloat progress) {
        [weakSelf showProgress:progress];
    } complate:^(BOOL success, NSString * _Nonnull errorCode) {
        [weakSelf hideProgress];
        [weakSelf dismiss];
        
        if (success) {
            [PhotonTipView showMessage:NSLocalizedString(@"photoDownload.save.success", nil)];
        } else {
            [PhotonTipView showMessage:errorCode];
        }
    }];
}

#pragma mark - Lazy
- (PIXDownloadAlert *)view {
    if (!_view) {
        _view = PIXDownloadAlert.new;
        [_view setFrame:UIScreen.mainScreen.bounds];
        [_view setDelegate:self];
    }
    return _view;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] init];
        _activityIndicator.frame = CGRectMake(0, 0, 44, 44);
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        [_activityIndicator setHidesWhenStopped:YES];
    }
    return _activityIndicator;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        UILabel *v = UILabel.new;
        [v setTextColor:UIColor.whiteColor];
        [v setFont:[PHAppskin appSFProDisplayRegularFont:14]];
        _progressLabel = v;
    }
    return _progressLabel;
}

#pragma mark - private
+ (NSURL *)getUrlFromPhotoItem:(PIXPhotoItem *)item {
    NSString *urlStr;
    if (item) {
        if (item.photoBiglUrl.length > 0) {
            urlStr = item.photoBiglUrl;
        }
        if (item.photoMiddlelUrl.length > 0) {
            urlStr = item.photoMiddlelUrl;
        }
        if (item.photoSmallUrl.length > 0) {
            urlStr = item.photoSmallUrl;
        }
    }
    
    if (urlStr) {
        return [NSURL URLWithString:urlStr];
    }
    return nil;
}

#pragma mark - Analytics
- (void)analyticShow {
//    type：A（下载券不够弹窗展示），B（消耗XX下载券弹窗展示）
    if (self.currentDownloadItem.type == PIXWallpaperEnableTypeUnpayAndLackOfBalance) {
        NSString *value = [NSString stringWithFormat:@"%ld_A", self.analytic_location];
        [FOAnalytics logEvent:@"Payment_Flow" values:@{kShow:value}];
    }  else if(self.currentDownloadItem.type == PIXWallpaperEnableTypeUnpayAndEnoughOfBalance) {
        NSString *value = [NSString stringWithFormat:@"%ld_B", self.analytic_location];
        [FOAnalytics logEvent:@"Payment_Flow" values:@{kShow:value}];
    }
}
- (void)analyticClick {
//    type：A（下载券不够弹窗点击），B（消耗XX下载券弹窗点击）
    if (self.currentDownloadItem.type == PIXWallpaperEnableTypeUnpayAndLackOfBalance) {
        NSString *value = [NSString stringWithFormat:@"%ld_A", self.analytic_location];
        [FOAnalytics logEvent:@"Payment_Flow" values:@{kClick:value}];
    }
    else if(self.currentDownloadItem.type == PIXWallpaperEnableTypeUnpayAndEnoughOfBalance) {
        NSString *value = [NSString stringWithFormat:@"%ld_B", self.analytic_location];
        [FOAnalytics logEvent:@"Payment_Flow" values:@{kClick:value}];
    }
}
@end
