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
    
    self.tableView.estimatedRowHeight = 150;
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
        model.content = @"我fadssafj就发生的垃圾费拉斯加积分撒旦法空间撒冷咖啡就上课垃圾分类卡萨积分拉斯克奖发来撒娇的罚款了撒娇附近的萨拉飞机阿斯利康的爱你发的说法是飞洒发生的发生法撒旦飞洒发撒旦法师法师的发的萨芬撒交付时间按时间放假啊双方就撒了房间爱上了房间打扫了房间爱上了对方附近的萨拉经费就爱上飞机是打飞机的撒发生";
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
    
    
    WSChatBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%d-%ld",model.isSender,(long)model.chatCellType] forIndexPath:indexPath];
    
   
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
