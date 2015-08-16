//
//  WSChatTableViewController.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatTableViewController.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatModel.h"

#define kBkColorTableView    ([UIColor colorWithRed:0.773 green:0.855 blue:0.824 alpha:1])

@interface WSChatTableViewController ()

@end

@implementation WSChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"张金磊";

    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kBkColorTableView;
    
   
   
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"1%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"0%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld-1",indexPath.row%2] forIndexPath:indexPath];
    
   
    
    return cell;
}




@end
