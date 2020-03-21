//
//  PIXDownloadAlert.m
//  Photon
//
//  Created by lg on 2019/12/13.
//  Copyright © 2019 everimaging. All rights reserved.
//

#import "PIXDownloadAlert.h"

@interface PIXDownloadAlert ()

@property(nonatomic,weak) id<PIXDownloadAlertItemProtocol> item;
@property(nonatomic) PIXDownloadAlertType type;

@end

@implementation PIXDownloadAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setBackgroundColor:[UIColor.blackColor colorWithAlphaComponent:0.5]];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nicknameLabelView];
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.actionBtn];
    [self.contentView addSubview:self.bottomLabel];
    [self addSubview:self.closeBtn];
    
    CGFloat width = self.bounds.size.width;
    CGFloat space = 24;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.center.equalTo(self).offset(@(-32));
        make.left.equalTo(@(space));
        make.right.equalTo(@(-space));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(space));
        make.centerX.equalTo(self.contentView);
        make.size.equalTo(@56);
    }];
    [self.iconImageView.layer setCornerRadius:28];
    [self.iconImageView setClipsToBounds:YES];
    
    [self.nicknameLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(@(16));
//        make.centerX.equalTo(self.contentView);
        make.left.equalTo(@(space));
        make.right.equalTo(@(-space));
    }];
    
    CGSize tipSize = [self.tipLabel sizeThatFits:CGSizeMake(width-4*space, CGFLOAT_MAX)];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabelView.mas_bottom).offset(@(8));
        make.left.equalTo(self.nicknameLabelView);
        make.right.equalTo(self.nicknameLabelView);
        make.height.equalTo(@(tipSize.height));
    }];
    
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLabel.mas_bottom).offset(@(space));
        make.left.equalTo(@(space));
        make.right.equalTo(@(-space));
        make.height.equalTo(@(40));
    }];
    [self.actionBtn.layer setCornerRadius:20];
    [self.actionBtn setClipsToBounds:YES];
    
    CGSize bottomLabelSize = [self.bottomLabel sizeThatFits:CGSizeMake(width-4*space, CGFLOAT_MAX)];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.actionBtn.mas_bottom).offset(@(12));
        make.bottom.equalTo(self.contentView).offset(@(-space));
//        make.centerX.equalTo(self.contentView);
        make.left.equalTo(@(space));
        make.right.equalTo(@(-space));
        make.height.equalTo(@(bottomLabelSize.height));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).equalTo(@(space));
        make.centerX.equalTo(self);
    }];
    
    [self hideAlert];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    CGFloat space = 24;
    CGFloat width = self.contentView.bounds.size.width;

    CGSize tipSize = [self.tipLabel sizeThatFits:CGSizeMake(width-2*space, CGFLOAT_MAX)];
//    NSLog(@"tipSize:%@", NSStringFromCGSize(tipSize));
    [self.tipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(tipSize.height));
    }];
    
    CGSize bottomLabelSize = [self.bottomLabel sizeThatFits:CGSizeMake(width-4*space, CGFLOAT_MAX)];
//    NSLog(@"bottomLabelSize:%@", NSStringFromCGSize(bottomLabelSize));
    [self.bottomLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(bottomLabelSize.height));
    }];
    
    switch (self.type) {
        case PIXDownloadAlertTypeDefault:
        case PIXDownloadAlertTypeUnexceptional: {
            
        }
            break;
        case PIXDownloadAlertTypeUnopen: {
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = touches.allObjects.firstObject;
//    CGPoint point = [touch locationInView:self.contentView];
//    if (![self.contentView pointInside:point withEvent:event]) {
//        [self dismiss];
//    } else {
//        [super touchesEnded:touches withEvent:event];
//    }
//}
#pragma mark - private
- (void)setItem:(id<PIXDownloadAlertItemProtocol>)item {
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.downloadAlertItem_headPortraitUrl] placeholderImage:kDefaultHeaderImage];
    [self.nicknameLabelView setText:item.downloadAlertItem_nickName];
}
- (void)setType:(PIXDownloadAlertType)type {
    _type = type;
    [self updateText];
}
- (void)updateText {
    switch (self.type) {
        case PIXDownloadAlertTypeDefault: {
            [self.tipLabel setText:NSLocalizedString(@"photoDownload.tip", nil)];
            [self.actionBtn setTitle:NSLocalizedString(@"photoDownload.actionBtn.title.pay", nil) forState:UIControlStateNormal];
            [self.bottomLabel setText:NSLocalizedString(@"photoDownload.bottom.tip", nil)];
        }
            break;
        case PIXDownloadAlertTypeUnexceptional:{
            [self.tipLabel setText:NSLocalizedString(@"photoDownload.tip", nil)];
            [self.actionBtn setTitle:NSLocalizedString(@"photoDownload.actionBtn.title.canDownloadAndNoPay", nil) forState:UIControlStateNormal];
            [self.bottomLabel setText:NSLocalizedString(@"photoDownload.bottom.tip", nil)];
        }
            break;
        case PIXDownloadAlertTypeUnexceptionalAndLeakOfBalance:{
            [self.tipLabel setText:NSLocalizedString(@"photoDownload.tip", nil)];
            [self.actionBtn setTitle:NSLocalizedString(@"photoDownload.actionBtn.title.buyTicket", nil) forState:UIControlStateNormal];
            [self.bottomLabel setText:NSLocalizedString(@"photoDownload.bottom.tip", nil)];
        }
            break;
        case PIXDownloadAlertTypeUnopen:{
            [self.tipLabel setText:NSLocalizedString(@"photoDownload.tip.unopen", nil)];
            [self.actionBtn setTitle:NSLocalizedString(@"photoDownload.actionBtn.title.unopen", nil) forState:UIControlStateNormal];
            [self.bottomLabel setText:nil];
        }
            break;
            
        default:
            break;
    }
    [self setNeedsUpdateConstraints];
}

#pragma mark - handler
- (void)clickActionBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(downloadAlert:clickActionType:)]) {
        [self.delegate downloadAlert:self clickActionType:self.type];
    } else {
    }
}
- (void)clickCloseBtn {
    [self dismiss];
}
#pragma mark - public

+ (PIXDownloadAlert *)showWithDownloadAlertItem:(id<PIXDownloadAlertItemProtocol>)item {
    PIXDownloadAlert *alert = [[PIXDownloadAlert alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIWindow *w = [UIApplication sharedApplication].keyWindow;
    [w addSubview:alert];
    
    [alert showAlertWithDownloadAlertItem:item animated:NO];
    return alert;
}

- (void)showAlertWithDownloadAlertItem:(id<PIXDownloadAlertItemProtocol>)item animated:(BOOL)animated {
    self.item = item;
    self.type = item.downloadAlertItem_type;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self showAlert];
        }];
    } else {
        [self showAlert];
    }
}
- (void)showAlert {
    [self.contentView setHidden:NO];
    [self.closeBtn setHidden:NO];
}
- (void)hideAlert {
    [self.contentView setHidden:YES];
    [self.closeBtn setHidden:YES];
}
- (void)dismiss {
    [self removeFromSuperview];
}
#pragma mark - Lazy
- (UIView *)contentView {
    if (!_contentView) {
        UIView *v = UIView.new;
        [v setBackgroundColor:UIColor.whiteColor];
        [v.layer setCornerRadius:8];
        _contentView = v;
    }
    return _contentView;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *v = UIImageView.new;
        [v setContentMode:UIViewContentModeScaleAspectFill];
        _iconImageView = v;
    }
    return _iconImageView;
}
- (UILabel *)nicknameLabelView {
    if (!_nicknameLabelView) {
        UILabel *v = UILabel.new;
        [v setFont:[PHAppskin appSFProDisplayMediumFont:16]];
        [v setTextColor:[PHAppskin grayColor30]];
        [v setTextAlignment:NSTextAlignmentCenter];
        _nicknameLabelView = v;
    }
    return _nicknameLabelView;
}
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        UILabel *v = UILabel.new;
        [v setFont:[PHAppskin appSFProDisplayRegularFont:14]];
        [v setTextColor:[PHAppskin grayColor30]];
        [v setTextAlignment:NSTextAlignmentCenter];
        [v setNumberOfLines:0];
        _tipLabel = v;
    }
    return _tipLabel;
}
- (UIButton *)actionBtn {
    if (!_actionBtn) {
        UIButton *v = UIButton.new;
        [v setBackgroundColor:[PHAppskin pxbeePrimaryColor]];
        [v setTitleColor:[PHAppskin grayColor30] forState:UIControlStateNormal];
        [v.titleLabel setFont:[PHAppskin appSFProDisplayMediumFont:14]];
        [v addTarget:self action:@selector(clickActionBtn) forControlEvents:UIControlEventTouchUpInside];
        _actionBtn = v;
    }
    return _actionBtn;
}
- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        UILabel *v = UILabel.new;
        [v setFont:[PHAppskin appSFProDisplayRegularFont:12]];
        [v setTextColor:[PHAppskin grayColor160]];
        [v setTextAlignment:NSTextAlignmentCenter];
        [v setNumberOfLines:0];
        _bottomLabel = v;
    }
    return _bottomLabel;
}
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        UIButton *v = UIButton.new;
        [v setTitleColor:[PHAppskin grayColor30] forState:UIControlStateNormal];
        [v setAdjustsImageWhenHighlighted:NO];
        [v addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        [v setImage:[UIImage imageNamed:@"invitationCardBottomIcon"] forState:UIControlStateNormal];
        [v setAdjustsImageWhenHighlighted:NO];
        
        _closeBtn = v;
    }
    return _closeBtn;
}
@end
