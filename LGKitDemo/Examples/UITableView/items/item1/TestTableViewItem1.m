//
//  TestTableViewItem1.m
//  LGKitDemo
//
//  Created by lg on 2019/12/26.
//  Copyright © 2019 lg. All rights reserved.
//

#import "TestTableViewItem1.h"

@implementation TestTableViewItem1

#pragma mark - TestTableViewItemProtocol

- (Class)cellClass {
    return TestTableViewTableViewCell.class;
}

@end
