//
//  WSChatModel.m
//  QQ
//
//  Created by weida on 15/12/21.
//  Copyright © 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatModel.h"

@implementation WSChatModel

+(NSString *)entityName
{
    return @"MsgHistory";
}

+(WSChatModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    return   [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}
// Insert code here to add functionality to your managed object subclass

@end
