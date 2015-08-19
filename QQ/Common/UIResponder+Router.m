//
//  UIResponder+UIResponder_Router.m
//  QQ
//
//  Created by weida on 15/8/19.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}


@end
