//
//  UIView+PIXNoDataView.m
//  Photon
//
//  Created by lg on 2019/11/27.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import "UIView+PIXNoDataView.h"
#import <objc/runtime.h>

@implementation UIView (PIXNoDataView)

- (UIView *)pix_noDataView
{
    UIView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        UIView *emptyView = [PHDIYEmptyView diyNoDataWithImage:self.pix_noDataImageName title:self.pix_noDataTitle detail:self.pix_noDataContent offsety:kEmptyDefualtOffsetY];
        [view addSubview:emptyView];
        self.pix_noDataView = view;
    }
    return view;
}
- (void)setPix_noDataView:(UIView *)pix_noDataView {
    objc_setAssociatedObject(self, @selector(pix_noDataView), pix_noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)pix_noDataImageName
{
    return objc_getAssociatedObject(self, @selector(setPix_noDataImageName:));
}
- (void)setPix_noDataImageName:(NSString *)pix_noDataImageName {
    objc_setAssociatedObject(self, _cmd, pix_noDataImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)pix_noDataTitle
{
    NSString *n = objc_getAssociatedObject(self, @selector(setPix_noDataTitle:));
    if (n) {
        return n;
    }
    return NSLocalizedString(@"no.data.title", nil);
}
- (void)setPix_noDataTitle:(NSString *)pix_noDataTitle {
    objc_setAssociatedObject(self, _cmd, pix_noDataTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)pix_noDataContent
{
    return objc_getAssociatedObject(self, @selector(setPix_noDataContent:));
}
- (void)setPix_noDataContent:(NSString *)pix_noDataContent {
    objc_setAssociatedObject(self, _cmd, pix_noDataContent, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - public
- (void)pix_showEmptyView {
    [self addSubview:self.pix_noDataView];
}
- (void)pix_resetEmptyView {
    [self.pix_noDataView removeFromSuperview];
}
@end
