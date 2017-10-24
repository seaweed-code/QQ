//
//  WSChatTimeTableViewCell.h
//  QQ
//
//  Created by weida on 15/8/16.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>


#define kTimeCellReusedID    (@"time")

@class WSChatModel;

@interface WSChatTimeTableViewCell : UITableViewCell

-(void)setModel:(WSChatModel *)model width:(CGFloat)width;

+(NSDictionary*)calculateSubViewsFramewithModel:(WSChatModel*) model width:(CGFloat) width;

@end
