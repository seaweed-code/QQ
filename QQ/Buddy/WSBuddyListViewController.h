//
//  TelphoneViewController.h
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>
#import "NSObject+CoreDataHelper.h"


/**
 *  @brief  我的好友列表
 */
@interface WSBuddyListViewController : UIViewController
{
    NSFetchedResultsController *_fetchedResultsController;
}


@end
