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
@property(nonatomic,strong)NSMutableArray *DataSource;
@end

@implementation WSChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"张金磊";

    [self SetData];
    
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kBkColorTableView;
    
   
   
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"1%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"0%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    
}

-(void)SetData
{
    for (NSInteger i = 0; i<=20; i++)
    {
        WSChatModel *model = [[WSChatModel alloc]init];
        
        model.isSender = i%2;
        model.content = @"你吃放放假了敬爱放暑假了飞洒的经济拉芳舍房间打扫考虑到家乐福见都洒了";
        model.chatCellType = WSChatCellType_Text;
        
        [self.DataSource addObject:model];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.DataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = self.DataSource[indexPath.row];
    
    
    WSChatBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%d-1",model.isSender] forIndexPath:indexPath];
    
   
    [cell setModel:model];
    
    return cell;
}

-(NSMutableArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    return _DataSource = @[].mutableCopy;
}


@end
