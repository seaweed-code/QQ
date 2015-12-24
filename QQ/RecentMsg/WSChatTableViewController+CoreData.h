//
//  WSChatTableViewController+CoreData.h
//  QQ
//
//  Created by weida on 15/12/24.
//  Copyright © 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTableViewController.h"

@interface WSChatTableViewController (CoreData)<NSFetchedResultsControllerDelegate>

@property(nonatomic,strong,readonly)NSFetchedResultsController *fetchedResultsController;



@end
