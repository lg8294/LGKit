//
//  ViewController.m
//  test
//
//  Created by 李刚 on 2017/11/24.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import "SwizzDeallocViewController.h"
#import "SwizzTestObject.h"
#import "SubSwizzTestObj.h"

@interface SwizzDeallocViewController ()

@end

@implementation SwizzDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)creatUser:(id)sender {
    SwizzTestObject *obj = [[SwizzTestObject alloc] init];
    [obj test];
}

- (IBAction)creatUser2:(id)sender {
    SubSwizzTestObj *obj = [[SubSwizzTestObj alloc] init];
    [obj test];
}

@end
