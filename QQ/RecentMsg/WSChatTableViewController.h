//
//  WSChatTableViewController.h
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/**
 *  @brief  聊天窗口
 */
@interface WSChatTableViewController : UIViewController
{
    NSFetchedResultsController *_fetchedResultsController;
}

@property(nonatomic,strong,readonly)UITableView  *tableView;

@end
