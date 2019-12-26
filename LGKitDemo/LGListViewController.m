//
//  LGListViewController.m
//  LGKitDemo
//
//  Created by iOS on 2017/11/27.
//  Copyright © 2017年 李刚. All rights reserved.
//

#import "LGListViewController.h"
#import "Model/LGListItem.h"

#import "Examples/SwizzDealloc/SwizzDeallocViewController.h"
#import "Examples/EasyKVO/EasyKVOTestViewController.h"
#import "Examples/UITableView/TestTableViewViewController.h"

@interface LGListViewController ()

@end

@implementation LGListViewController {
    NSMutableArray *_modelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelList = [@[] mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    LGListItem *swizzDeallocTestItem = [[LGListItem alloc] initWithTitle:@"SwizzDealloc" subtitle:nil content:@"swizz Dealloc" handle:^{
        SwizzDeallocViewController *vc = [mainSB instantiateViewControllerWithIdentifier:@"SwizzDeallocViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [_modelList addObject:swizzDeallocTestItem];
    
    LGListItem *easyKVOTestItem = [[LGListItem alloc] initWithTitle:@"EasyKVO" subtitle:nil content:@"测试 KVO" handle:^{
        EasyKVOTestViewController *vc = [mainSB instantiateViewControllerWithIdentifier:@"EasyKVOTestViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [_modelList addObject:easyKVOTestItem];
    
    LGListItem *tableViewTestItem = [[LGListItem alloc] initWithTitle:@"TableView" subtitle:nil content:@"测试 UITableView" handle:^{
        TestTableViewViewController *vc = TestTableViewViewController.new;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [_modelList addObject:tableViewTestItem];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (IBAction)refreshAction:(id)sender {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _modelList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listItem" forIndexPath:indexPath];
    LGListItem *item = _modelList[indexPath.section];
    // Configure the cell...
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.content;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LGListItem *item = _modelList[indexPath.section];
    if (item.handle) {
        item.handle();
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
