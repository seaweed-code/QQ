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
#import "WSChatTableViewController+CoreData.h"


@interface WSChatTableViewController ()

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
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    WSChatModel *newModel = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    newModel.chatCellType = userInfo[@"type"];
    newModel.isSender     = @(YES);
    newModel.timeStamp    = [NSDate date];
    
    switch ([newModel.chatCellType integerValue])
    {
        case WSChatCellType_Text:
            
             newModel.content      = userInfo[@"text"];
            
            break;
            
        default:
            break;
    }
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}


/**
 *  @brief  删除模型
 *
 *  @param model 模型
 */
-(void)RemoveModel:(WSChatModel *)model
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    [context deleteObject:model];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
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
        case 0:
        
            model.chatCellType = @(WSChatCellType_Image);
            model.content = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"app%d",i%8+1] withExtension:@"png"].absoluteString;
            
            break;
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
    
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
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

@end
