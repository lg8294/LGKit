//
//  Define.h
//
//  Created by Haijun.
//




/// 是否iPhoneX
#define kIs_iPhoneX ([UIApplication sharedApplication].statusBarFrame.size.height > 20)
/// 导航栏+状态栏高度
#define kNav_H ([UIApplication sharedApplication].statusBarFrame.size.height + 44)
/// TabBar高度
#define kTAB_H (kIs_iPhoneX ? 83 : 49)
/// 底部安全距离
#define kSafeBottom (kIs_iPhoneX ? 34 : 0)
/// 顶部安全距离
#define kSafeTop ([UIApplication sharedApplication].statusBarFrame.size.height)



/// 从xib加载视图
#define kNib_Name(NAME) [UINib nibWithNibName:NAME bundle:nil]

/// 设置ScrollView顶部无间距
#define kScrollInsetNever(VC, SCROLL) \
    if (@available(iOS 11.0, *)) { SCROLL.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; } \
    else { VC.automaticallyAdjustsScrollViewInsets = NO; }

/// 在scrollView中固定View.frame.origin.y
#define kLockViewY(VIEW, SCROLLVIEW) \
    ({  \
        CGRect frame = VIEW.frame;  \
        frame.origin.y = SCROLLVIEW.contentOffset.y;   \
        VIEW.frame = frame;     \
    })

/// NSLog
#if DEBUG
    #define NSLog(FORMAT, ...) printf("%s(%d):\n%s\n-------------------- END --------------------\n\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:(FORMAT), ##__VA_ARGS__] UTF8String])
#else
    #define NSLog(FORMAT, ...) nil
#endif

/// 服务器BaseURL
//#define kBaseURL @"http://test.deepinfo.cn/bnyh/public/member/app/"
//#define kBaseURL @"http://192.168.1.149/bnyh/public/member/app/"
#define kBaseURL @"http://business.bainianapp.com/public/member/app/"
//#define kBaseURL @"http://education.totorovip.com/member/app/"

#define kZhidianBaseURL @"http://app.bainianapp.com/v3/"
//@"http://100.app.yuntim.cn/v3/"

#define kPageItemMax 10
#define kImageDefault [UIImage imageNamed:@"ic_img_placeholder"]
#define kAvatarDefault [UIImage imageNamed:@"ic_avatar_default"]
#define kBannerDefault [UIImage imageNamed:@"ic_img_banner"]

#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
