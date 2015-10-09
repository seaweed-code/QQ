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
#import "WSChatVoiceTableViewCell.h"
#import "WSChatTimeTableViewCell.h"
#import "WSChatMessageInputBar.h"
#import "UITableView+FDTemplateLayoutCell.h"


#define kBkColorTableView    ([UIColor colorWithRed:0.773 green:0.855 blue:0.824 alpha:1])

@interface WSChatTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   
}
@property(nonatomic,strong)NSMutableArray *DataSource;


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)WSChatMessageInputBar *inputBar;

@end

@implementation WSChatTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"张金磊";
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeBottom];

    
    [self.view addSubview:self.inputBar];
    [self.inputBar autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTop];
    [self.inputBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
}


#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = self.DataSource[indexPath.row];
    
    NSInteger height = model.height;
    
    if (!height)
    {
       height = [tableView fd_heightForCellWithIdentifier:kCellReuseID(model) configuration:^(WSChatBaseTableViewCell* cell)
         {
             [cell setModel:model];
         }];

    }
    
    return height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = self.DataSource[indexPath.row];
    
    WSChatBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID(model) forIndexPath:indexPath];
    
    [cell setModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

#pragma mark - UIResponder actions
-(void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo
{
    WSChatModel *model = [userInfo objectForKey:kModelKey];
    
    switch (eventType)
    {
        case EventChatCellTypeSendMsgEvent:
       
            [self.view endEditing:YES];
            [self SendMessage:userInfo];
            
            break;
        case EventChatCellRemoveEvent:
        
            [self RemoveModel:model];
            
            break;
        case EventChatCellImageTapedEvent:
            NSLog(@"点击了图片了。。");
            
            break;
        case EventChatCellHeadTapedEvent:
            NSLog(@"头像被点击了。。。");
            break;
        case EventChatCellHeadLongPressEvent:
            NSLog(@"头像被长按了。。。。");
            break;
        default:
            break;
    }

}


-(void)SendMessage:(NSDictionary*)userInfo
{
    WSChatModel *newModel = [[WSChatModel alloc]init];
    newModel.chatCellType = [userInfo[@"type"]integerValue];
    newModel.isSender     = YES;
    
    switch (newModel.chatCellType)
    {
        case WSChatCellType_Text:
            
             newModel.content      = userInfo[@"text"];
            
            break;
            
        default:
            break;
    }
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.DataSource.count inSection:0];
    [self.DataSource addObject:newModel];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


/**
 *  @brief  删除模型
 *
 *  @param model 模型
 */
-(void)RemoveModel:(WSChatModel *)model
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:[self.DataSource indexOfObject:model] inSection:0];
    
    NSMutableArray *indexs = @[index].mutableCopy;
    
    NSMutableIndexSet *indexSets = [NSMutableIndexSet indexSetWithIndex:index.row];
    
    
    if ((index.row > 0) && ((WSChatModel*)(self.DataSource[index.row-1])).chatCellType == WSChatCellType_Time)
    {
        if((index.row == self.DataSource.count-1) || (((WSChatModel*)(self.DataSource[index.row+1])).chatCellType == WSChatCellType_Time))
        {//删除上一个
            
            [indexSets addIndex:index.row-1];
            [indexs addObject:[NSIndexPath indexPathForRow:index.row-1 inSection:0]];
        }
    }
    
    [self.DataSource removeObjectsAtIndexes:indexSets];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];

}


#pragma mark - Getter Method

-(WSChatMessageInputBar *)inputBar
{
    if (_inputBar) {
        return _inputBar;
    }
    
    _inputBar = [[WSChatMessageInputBar alloc]init];
    _inputBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    return _inputBar;
}

-(UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    _tableView                      =   [UITableView newAutoLayoutView];
    _tableView.fd_debugLogEnabled   =   NO;
    _tableView.separatorStyle       =   UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor      =   kBkColorTableView;
    _tableView.delegate             =   self;
    _tableView.dataSource           =   self;
    _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
    
    [_tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(1, (long)WSChatCellType_Text)];
    [_tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(0, (long)WSChatCellType_Text)];

    [_tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(1, (long)WSChatCellType_Image)];
    [_tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(0, (long)WSChatCellType_Image)];
    
    [_tableView registerClass:[WSChatVoiceTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(0, (long)WSChatCellType_Audio)];
    [_tableView registerClass:[WSChatVoiceTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(1, (long)WSChatCellType_Audio)];
    
    [_tableView registerClass:[WSChatTimeTableViewCell class] forCellReuseIdentifier:kTimeCellReusedID];
    
    
    return _tableView;
}

-(NSMutableArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    NSInteger capacity = 200;
    
    _DataSource = [NSMutableArray arrayWithCapacity:capacity];
    
    NSArray *strs = @[@"fdasfdsafdfsa",
                      @"454446545656656",
                      @"及时组织防化专业力量，先后9次进入爆炸现场，采集了土壤样品、检测沾染的数据，获得第一手资料。主要查明有害物质的种类、位置和危险程度，为现场指挥、决策和组织救援提供可靠的依据。",
                      @"史鲁泽说，事故核心区危险减弱了以后，16日上午，北京卫戍区防化团在爆炸现场附近的前方指挥部，军事医学科学院毒物药物研究所研究小组介绍，截至11时左右，从现场搜救的官兵等人员身上还没有发现化学沾染病例。",
                      @"dfsafdafdsafdsa"];
    
    
    NSInteger num = 0;
    for (NSInteger i = 0; i<capacity; i++)
    {
        WSChatModel *model = [[WSChatModel alloc]init];
        
        switch (i%4) {
            case 0:
                
                model.chatCellType = WSChatCellType_Image;
                
                model.content = [NSString stringWithFormat:@"app%ld",++num%8+1];
                
                
                break;
            case 1:
                
                 model.chatCellType = WSChatCellType_Text;
                
                model.content = strs[num%5];
                
                
                
                break;
            case 2:
                
                model.chatCellType = WSChatCellType_Audio;
                
                model.secondVoice = num;
                
                break;
            default:
                
                model.chatCellType = WSChatCellType_Time;
                
                model.content = @"下午9:00";
                
                break;
        }
        
        model.isSender = num%2;
       

        [_DataSource addObject:model];
    }
    
    
    return _DataSource;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
