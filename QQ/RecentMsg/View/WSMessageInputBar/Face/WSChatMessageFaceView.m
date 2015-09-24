//
//  WSChatMessageFaceView.m
//  QQ
//
//  Created by weida on 15/9/24.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatMessageFaceView.h"
#import "PureLayout.h"

#define kHeightFaceView     (170)

#define kBkColorSendBtn      ([UIColor colorWithRed:0.090 green:0.490 blue:0.976 alpha:1])

#define kHeightBtn           (30)

@implementation WSChatMessageFaceView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        /**
         *  @brief  最近按钮
         */
        UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [historyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        historyBtn.translatesAutoresizingMaskIntoConstraints = NO;
        historyBtn.backgroundColor = [UIColor clearColor];
      //  historyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [historyBtn setImage:[UIImage imageNamed:@"qvip_emoji_tab_history"] forState:UIControlStateNormal];
        [historyBtn  setImage:[UIImage imageNamed:@"qvip_emoji_tab_history_pressed"] forState:UIControlStateSelected];
        
        [self addSubview:historyBtn];
        [historyBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [historyBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
      //  [historyBtn autoSetDimension:ALDimensionHeight toSize:kHeightBtn];
        
       
        /**
         *  @brief  经典按钮
         */
        UIButton *classicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [classicBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        classicBtn.translatesAutoresizingMaskIntoConstraints = NO;
        classicBtn.backgroundColor = [UIColor clearColor];
        
       // classicBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [classicBtn setImage:[UIImage imageNamed:@"qvip_emoji_tab_classic"] forState:UIControlStateNormal];
        [classicBtn  setImage:[UIImage imageNamed:@"qvip_emoji_tab_classic_pressed"] forState:UIControlStateSelected];
        
        [self addSubview:classicBtn];
        [classicBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:historyBtn];
        [classicBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [classicBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:historyBtn];
        [classicBtn  autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:historyBtn];
        
        
        
        /**
         *  @brief  大表情
         */
        UIButton *storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        storeBtn.translatesAutoresizingMaskIntoConstraints = NO;
        storeBtn.backgroundColor = [UIColor clearColor];
        [storeBtn setImage:[UIImage imageNamed:@"qvip_emoji_tab_store"] forState:UIControlStateNormal];
        
        [self addSubview:storeBtn];
        [storeBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:classicBtn];
        [storeBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [storeBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:historyBtn];
        [storeBtn  autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:historyBtn];
        
        
        /**
         *  @brief  发送按钮
         */
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        sendBtn.translatesAutoresizingMaskIntoConstraints = NO;
        sendBtn.backgroundColor = kBkColorSendBtn;
        
        [self addSubview:sendBtn];
        [sendBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:storeBtn];
        [sendBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [sendBtn  autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [sendBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:historyBtn];
        [sendBtn  autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:historyBtn];
        
        
        
        
    }
    return self;
}

-(void)btnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


-(CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kHeightFaceView);
}

@end
