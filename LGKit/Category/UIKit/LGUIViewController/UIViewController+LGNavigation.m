//
//  UIViewController+LGNavigation.m
//  Photon
//
//  Created by lg on 2020/2/25.
//  Copyright © 2020 everimaging. All rights reserved.
//

#import "UIViewController+LGNavigation.h"

@implementation UIViewController (LGNavigation)

- (void)lg_goback {
    if (self.navigationController) {
        if (self.navigationController.childViewControllers.count == 1) {
            if (self.presentingViewController) {
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        if (self.presentingViewController) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
@end
