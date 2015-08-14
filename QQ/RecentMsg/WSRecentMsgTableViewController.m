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

#define kSetTableView(tableView)   {\
  [tableView registerClass:[WSRecentMsgTableViewCell class] forCellReuseIdentifier:kReusedID];\
   tableView.rowHeight = kHeightTableViewCell;\
   tableView.separatorStyle = UITableViewCellSeparatorStyleNone;}


@interface WSRecentMsgTableViewController ()<UISearchDisplayDelegate>
{
    UISearchDisplayController *msearchDisplay;
}

@property(nonatomic,strong)NSMutableArray *DataSource;
@end

@implementation WSRecentMsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.DataSource addObject:@"fdasfasf"];
   
    self.view.backgroundColor = [UIColor whiteColor];
   
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    searchBar.placeholder = @"搜索";

    self.tableView.tableHeaderView = searchBar;
    
     msearchDisplay= [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    msearchDisplay.searchResultsDataSource = self;
    msearchDisplay.searchResultsDelegate = self;
   
    kSetTableView(msearchDisplay.searchResultsTableView);

    kSetTableView(self.tableView);
    
   
}


#pragma mark --TableView Delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataSource.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSRecentMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedID forIndexPath:indexPath];


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSMutableArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    _DataSource = @[].mutableCopy;
    
    return _DataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
