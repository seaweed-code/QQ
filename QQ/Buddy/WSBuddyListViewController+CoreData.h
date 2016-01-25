//
//  WSBuddyListViewController+CoreData.h
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSBuddyListViewController.h"

@interface WSBuddyListViewController (CoreData)<NSFetchedResultsControllerDelegate>

@property(nonatomic,strong,readonly)NSFetchedResultsController *fetchedResultsController;

@end
