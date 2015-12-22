//
//  WSChatTableViewController.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTableViewController.h"
#import "WSChatModel.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatImageTableViewCell.h"
#import "WSChatVoiceTableViewCell.h"
#import "WSChatTimeTableViewCell.h"
#import "WSChatMessageInputBar.h"
#import "UITableView+FDTemplateLayoutCell.h"


#define kBkColorTableView    ([UIColor colorWithRed:0.773 green:0.855 blue:0.824 alpha:1])

@interface WSChatTableViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
   
}
//@property(nonatomic,strong)NSMutableArray *DataSource;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
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
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(insertNewObject:) userInfo:nil repeats:YES];
}


#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
   
    CGFloat height = model.height.floatValue;
    
    if (!height)
    {
       height = [tableView fd_heightForCellWithIdentifier:kCellReuseID(model) configuration:^(WSChatBaseTableViewCell* cell)
         {
             [cell setModel:model];
         }];
        
        model.height = @(height);

    }
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    WSChatBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID(model) forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(WSChatBaseTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.model = model;
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
          //  [self SendMessage:userInfo];
            
            break;
        case EventChatCellRemoveEvent:
        
           // [self RemoveModel:model];
            
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

//
//-(void)SendMessage:(NSDictionary*)userInfo
//{
//    WSChatModel *newModel = [[WSChatModel alloc]init];
//    newModel.chatCellType = [userInfo[@"type"]integerValue];
//    newModel.isSender     = YES;
//    
//    switch (newModel.chatCellType)
//    {
//        case WSChatCellType_Text:
//            
//             newModel.content      = userInfo[@"text"];
//            
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.DataSource.count inSection:0];
//    [self.DataSource addObject:newModel];
//    
//    [self.tableView beginUpdates];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView endUpdates];
//    
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//}
//
//
///**
// *  @brief  删除模型
// *
// *  @param model 模型
// */
//-(void)RemoveModel:(WSChatModel *)model
//{
//    NSIndexPath *index = [NSIndexPath indexPathForRow:[self.DataSource indexOfObject:model] inSection:0];
//    
//    NSMutableArray *indexs = @[index].mutableCopy;
//    
//    NSMutableIndexSet *indexSets = [NSMutableIndexSet indexSetWithIndex:index.row];
//    
//    
//    if ((index.row > 0) && ((WSChatModel*)(self.DataSource[index.row-1])).chatCellType == WSChatCellType_Time)
//    {
//        if((index.row == self.DataSource.count-1) || (((WSChatModel*)(self.DataSource[index.row+1])).chatCellType == WSChatCellType_Time))
//        {//删除上一个
//            
//            [indexSets addIndex:index.row-1];
//            [indexs addObject:[NSIndexPath indexPathForRow:index.row-1 inSection:0]];
//        }
//    }
//    
//    [self.DataSource removeObjectsAtIndexes:indexSets];
//    
//    [self.tableView beginUpdates];
//    [self.tableView deleteRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView endUpdates];
//
//}


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
    
    _tableView                      =   [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.fd_debugLogEnabled   =   NO;
    _tableView.separatorStyle       =   UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor      =   kBkColorTableView;
    _tableView.delegate             =   self;
    _tableView.dataSource           =   self;
    _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
    
    [_tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@1,@(WSChatCellType_Text))];
    [_tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@0,@(WSChatCellType_Text))];

    [_tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@1, @(WSChatCellType_Image))];
    [_tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@0, @(WSChatCellType_Image))];
    
    [_tableView registerClass:[WSChatVoiceTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@0, @(WSChatCellType_Audio))];
    [_tableView registerClass:[WSChatVoiceTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@1, @(WSChatCellType_Audio))];
    
    [_tableView registerClass:[WSChatTimeTableViewCell class] forCellReuseIdentifier:kTimeCellReusedID];
    
    
    return _tableView;
}

- (void)insertNewObject:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    WSChatModel *model = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
   
    static int i=0;
    
    NSArray *strs = @[@"fdasfdsafdfsa",
                      @"454446545656656",
                      @"及时组织防化专业力量，先后9次进入爆炸现场，采集了土壤样品、检测沾染的数据，获得第一手资料。主要查明有害物质的种类、位置和危险程度，为现场指挥、决策和组织救援提供可靠的依据。",
                      @"史鲁泽说，事故核心区危险减弱了以后，16日上午，北京卫戍区防化团在爆炸现场附近的前方指挥部，军事医学科学院毒物药物研究所研究小组介绍，截至11时左右，从现场搜救的官兵等人员身上还没有发现化学沾染病例。",
                      @"dfsafdafdsafdsa"];

    
    switch (i++%4)
    {
//        case 0:
//            
//            model.chatCellType = @(WSChatCellType_Image);
//            
//            // model.content = [NSString stringWithFormat:@"app%ld",++num%8+1];
//            
//            
//            break;
        case 1:
            
            model.chatCellType = WSChatCellType_Time;
            
            model.content = @"下午9:00";
            
            break;
        case 2:
            
            model.chatCellType = @(WSChatCellType_Audio);
            
            model.secondVoice = @(i%60);
            
            break;
       
        default:
            
            model.chatCellType = @(WSChatCellType_Text);
            
            model.content = strs[i%5];
            
            
            
            break;
    }
    
    model.isSender = @(i%2);
    model.timeStamp = [NSDate date];
    
    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appdelete = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appdelete.managedObjectContext;
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MsgHistory" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:5];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"History"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {//让其滚动到底部
        NSInteger section = [[self.fetchedResultsController sections] count];
        if (section >= 1)
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section-1];
            NSInteger row =  [sectionInfo numberOfObjects];
            if (row >= 1)
            {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section-1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        }
        
        
    });

}

@end
