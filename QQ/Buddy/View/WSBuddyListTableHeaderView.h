//
//  WSBuddyListTableHeaderView.h
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class WSBuddyGroupModel;

@interface WSBuddyListTableHeaderView : UITableViewHeaderFooterView

@property(nonatomic,strong) WSBuddyGroupModel *groupModel;

@end
