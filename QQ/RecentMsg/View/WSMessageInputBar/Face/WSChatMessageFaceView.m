//
//  WSChatMessageFaceView.m
//  QQ
//
//  Created by weida on 15/9/24.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatMessageFaceView.h"

#define kHeightFaceView     (170)

@implementation WSChatMessageFaceView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}


-(CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kHeightFaceView);
}

@end
