//
//  MessageViewController.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSRecentMsgTableViewController.h"
#import "WSRecentMsgTableViewCell.h"



#define kReusedID        (@"reused")

#define kHeightTableViewCell  (60)



@interface WSRecentMsgTableViewController ()

@end

@implementation WSRecentMsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.tableView registerClass:[WSRecentMsgTableViewCell class] forCellReuseIdentifier:kReusedID];
    
    self.tableView.rowHeight = kHeightTableViewCell;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}


#pragma mark --TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSRecentMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedID forIndexPath:indexPath];


    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
