//
//  QTTableViewController.m
//  QTSeparatorInsetTableView
//
//  Created by Tang Qi on 27/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "QTTableViewController.h"

@interface QTTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QTTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    // 直接且仅设置 tableView 的 separatorInset，在 iOS 8.x 9.x 10.x 上会得到不一样的结果
    //    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.separatorInset = UIEdgeInsetsMake(0, 3, 0, 11);
    //    self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
    //    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If cell margins are derived from the width of the readableContentGuide.
    // NS_AVAILABLE_IOS(9_0)，需进行判断
    // 设置为 NO，防止在横屏时留白
    if ([tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
        tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }

    // Prevent the cell from inheriting the Table View's margin settings.
    // NS_AVAILABLE_IOS(8_0)，需进行判断
    // 阻止 Cell 继承来自 TableView 相关的设置（LayoutMargins or SeparatorInset），设置为 NO 后，Cell 可以独立地设置其自身的分割线边距而不依赖于 TableView
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    // Remove seperator inset.
    // NS_AVAILABLE_IOS(8_0)，需进行判断
    // 移除 Cell 的 layoutMargins（即设置为 0）
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    // Explictly set your cell's layout margins.
    // NS_AVAILABLE_IOS(7_0)，需进行判断
    // 根据需求设置相应的边距
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];

    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
