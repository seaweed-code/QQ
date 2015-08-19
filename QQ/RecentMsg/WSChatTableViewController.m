//
//  WSChatTableViewController.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatTableViewController.h"
#import "WSChatModel.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatImageTableViewCell.h"
#import "WSChatTimeTableViewCell.h"

#define kBkColorTableView    ([UIColor colorWithRed:0.773 green:0.855 blue:0.824 alpha:1])

@interface WSChatTableViewController ()
@property(nonatomic,strong)NSMutableArray *DataSource;
@end

@implementation WSChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"张金磊";

    
    self.tableView.estimatedRowHeight = 150;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kBkColorTableView;
    
   
   
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"1%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"0%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    
    [self.tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"1%@%ld",kReuseIDSeparate,(long)WSChatCellType_Image]];
    [self.tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"0%@%ld",kReuseIDSeparate,(long)WSChatCellType_Image]];
    
    [self.tableView registerClass:[WSChatTimeTableViewCell class] forCellReuseIdentifier:kTimeCellReusedID];
    
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
    
    WSChatBaseTableViewCell *cell;
    
    NSString *reuseID = nil;
    
    if (model.chatCellType == WSChatCellType_Time)
    {
        reuseID = kTimeCellReusedID;
    }else
    {
        reuseID = [NSString stringWithFormat:@"%d-%ld",model.isSender,(long)model.chatCellType];
    }
    
   
    cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
   
    [cell setModel:model];
    
    return cell;
}


-(NSMutableArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    _DataSource = [NSMutableArray arrayWithCapacity:200];
    
    NSArray *strs = @[@"fdasfdsafdfsa",
                      @"454446545656656",
                      @"史鲁泽说，事故核心区危险减弱了以后，及时组织防化专业力量，先后9次进入爆炸现场，采集了土壤样品、检测沾染的数据，获得第一手资料。主要查明有害物质的种类、位置和危险程度，为现场指挥、决策和组织救援提供可靠的依据。16日上午，北京卫戍区防化团在爆炸现场附近的前方指挥部，军事医学科学院毒物药物研究所研究小组介绍，截至11时左右，从现场搜救的官兵等人员身上还没有发现化学沾染病例。",
                      @"dfsafdafdsafdsa"];
    
    
    NSInteger num = 0;
    for (NSInteger i = 0; i<200; i++)
    {
        WSChatModel *model = [[WSChatModel alloc]init];
        
        switch (i%3) {
            case 0:
                
                model.chatCellType = WSChatCellType_Image;
                
                model.content = [NSString stringWithFormat:@"app%ld",++num%8+1];
                
                
                break;
            case 1:
                
                 model.chatCellType = WSChatCellType_Text;
                
                model.content = strs[i%4];
                
                
                
                break;
            default:
                
                model.chatCellType = WSChatCellType_Time;
                
                model.content = @"下午9:00";
                
                break;
        }
        
        model.isSender = i%2;
       

        [_DataSource addObject:model];
    }
    
    
    return _DataSource;
}

@end
