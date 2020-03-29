//
//  UIView+LGNoDataView.m
//
//  Created by lg on 2019/11/27.
//

#import "UIView+LGNoDataView.h"
#import <objc/runtime.h>

@implementation UIView (LGNoDataView)

- (UIView *)lg_noDataView
{
    UIView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
//        UIView *emptyView = [PHDIYEmptyView diyNoDataWithImage:self.lg_noDataImageName title:self.lg_noDataTitle detail:self.lg_noDataContent offsety:kEmptyDefualtOffsetY];
//        [view addSubview:emptyView];
        self.lg_noDataView = view;
    }
    return view;
}
- (void)setLg_noDataView:(UIView *)lg_noDataView {
    objc_setAssociatedObject(self, @selector(lg_noDataView), lg_noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)lg_noDataImageName
{
    return objc_getAssociatedObject(self, @selector(setLg_noDataImageName:));
}
- (void)setLg_noDataImageName:(NSString *)lg_noDataImageName {
    objc_setAssociatedObject(self, _cmd, lg_noDataImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lg_noDataTitle
{
    NSString *n = objc_getAssociatedObject(self, @selector(setLg_noDataTitle:));
    if (n) {
        return n;
    }
    return NSLocalizedString(@"no.data.title", nil);
}
- (void)setLg_noDataTitle:(NSString *)lg_noDataTitle {
    objc_setAssociatedObject(self, _cmd, lg_noDataTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lg_noDataContent
{
    return objc_getAssociatedObject(self, @selector(setLg_noDataContent:));
}
- (void)setLg_noDataContent:(NSString *)lg_noDataContent {
    objc_setAssociatedObject(self, _cmd, lg_noDataContent, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - public
- (void)lg_showNoDataView {
    [self addSubview:self.lg_noDataView];
}
- (void)lg_resetNoDataView {
    [self.lg_noDataView removeFromSuperview];
}
@end
