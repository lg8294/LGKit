//
//  TestTableViewViewController.m
//  LGKitDemo
//
//  Created by lg on 2019/12/26.
//  Copyright © 2019 lg. All rights reserved.
//

#import "TestTableViewViewController.h"
#import <LGKit/UITableView+LG.h>

#import "TestTableViewItemProtocol.h"
#import "TestTableViewItem1.h"
#import "TestTableViewItem2.h"

@interface TestTableViewViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) UITableView *tableView;

@property(nonatomic) NSArray<NSObject<TestTableViewItemProtocol>*> *datas;

@end

@implementation TestTableViewViewController

- (void)loadView {
    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self initData];
}

- (void)initData {
    NSMutableArray *array = [@[] mutableCopy];
    for (int i=0; i<10; i++) {
        if (i%2 == 0) {
            TestTableViewItem1 *item = TestTableViewItem1.new;
            [array addObject:item];
        } else {
            TestTableViewItem2 *item = TestTableViewItem2.new;
            [array addObject:item];
        }
    }
    self.datas = [array copy];
    
    UILabel *headerView = UILabel.new;
    [headerView setBackgroundColor:UIColor.redColor];
    [headerView setText:@"TableView Header"];
    [headerView setTextAlignment:NSTextAlignmentCenter];
    [headerView sizeToFit];
    [self.tableView setLg_tableHeaderView:headerView];
    
    UILabel *footerView = UILabel.new;
    [footerView setBackgroundColor:UIColor.greenColor];
    [footerView setText:@"TableView Footer"];
    [footerView setTextAlignment:NSTextAlignmentCenter];
    [footerView sizeToFit];
    [self.tableView setLg_tableFooterView:footerView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<TestTableViewItemProtocol> *data = self.datas[indexPath.row];
    
    UITableViewCell *cell = [tableView lg_dequeueReusableCellWithClass:data.cellClass forIndexPath:indexPath];
    cell.textLabel.text = NSStringFromClass(data.cellClass);
    
    return cell;
}
#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *v = UITableView.new;
        _tableView = v;
    }
    return _tableView;
}

@end
