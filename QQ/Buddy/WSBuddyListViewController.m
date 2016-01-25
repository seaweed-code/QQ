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

#define kReusedCellID    (@"unique")

@interface WSBuddyListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSBuddyModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    WSBuddyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedCellID forIndexPath:indexPath];
    
   // [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
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
    _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[WSBuddyListTableViewCell class] forCellReuseIdentifier:kReusedCellID];
    
    _refreshControl                 =  [[ODRefreshControl alloc]initInScrollView:_tableView];
    [_refreshControl addTarget:self action:@selector(refreshBuddyList) forControlEvents:UIControlEventValueChanged];
    
    return _tableView;
}

@end
