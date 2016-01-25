//
//  WSBuddyListViewController+CoreData.m
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSBuddyListViewController+CoreData.h"
#import "WSBuddyModel.h"

@implementation WSBuddyListViewController (CoreData)


#pragma mark - Getter Mehod

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [WSBuddyModel entityInManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nickName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"groupName" cacheName:nil];
    aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _fetchedResultsController;
}


@end
