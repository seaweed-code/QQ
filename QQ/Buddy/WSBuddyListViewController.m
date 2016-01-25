//
//  TelphoneViewController.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSBuddyListViewController.h"
#import "WSBuddyListViewController+CoreData.h"
#import "WSBuddyModel.h"
#import "WSBuddylistTableViewCell.h"
#import "WSBuddyListTableHeaderView.h"

#define kReusedCellID         (@"unique")
#define kRowHeight            (44)
#define kSectionHeaderHeight  (40)

@interface WSBuddyListViewController ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation WSBuddyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系人";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

#pragma mark - TableView Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSBuddyModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    WSBuddyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedCellID forIndexPath:indexPath];
    cell.model = model;
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WSBuddyListTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kReusedCellID];
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadView
{
    self.view = self.tableView;
}

#pragma mark - Getter Method

-(UITableView *)tableView
{
    if (_tableView)
    {
        return _tableView;
    }
    
    _tableView                      =   [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.separatorStyle       =   UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor      =   [UIColor whiteColor];
    _tableView.delegate             =   self;
    _tableView.dataSource           =   self;
    _tableView.rowHeight            =   kRowHeight;
    _tableView.sectionHeaderHeight  =   kSectionHeaderHeight;
    _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[WSBuddyListTableViewCell class] forCellReuseIdentifier:kReusedCellID];
    [_tableView registerClass:[WSBuddyListTableHeaderView class] forHeaderFooterViewReuseIdentifier:kReusedCellID];
    
    _refreshControl                 =  [[ODRefreshControl alloc]initInScrollView:_tableView];
    [_refreshControl addTarget:self action:@selector(refreshBuddyList) forControlEvents:UIControlEventValueChanged];
    
    return _tableView;
}

@end
