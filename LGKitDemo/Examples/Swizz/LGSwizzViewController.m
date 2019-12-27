//
//  LGSwizzViewController.m
//  LGKitDemo
//
//  Created by lg on 2019/12/27.
//  Copyright © 2019 lg. All rights reserved.
//

#import "LGSwizzViewController.h"
#import "LGSwizzSubClass.h"

@interface LGSwizzViewController ()

@property(nonatomic) UIButton *testBtn;

@end

@implementation LGSwizzViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [self.view addSubview:self.testBtn];
    [self.testBtn sizeToFit];
    [self.testBtn setCenter:self.view.center];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Action
- (void)action {
    LGSwizzSuperClass *spc = LGSwizzSuperClass.new;
    NSLog(@"spc call customMethod");
    [spc customMethod];
    
    LGSwizzSubClass *sbc = LGSwizzSubClass.new;
    NSLog(@"sbc call customMethod");
    [sbc customMethod];
    [sbc test];
}
#pragma mark - Lazy
- (UIButton *)testBtn {
    if (!_testBtn) {
        UIButton *v = [UIButton buttonWithType:UIButtonTypeSystem];
        [v setTitle:@"Test" forState:UIControlStateNormal];
        [v addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        _testBtn = v;
    }
    return _testBtn;
}
@end
