//
//  WSChatVoiceTableViewCell.m
//  QQ
//
//  Created by weida on 15/9/22.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatVoiceTableViewCell.h"


#define kHMinOffsetSecondLable_supView            (40)  //水平方向上，秒数Lable和父控件之间最小间隙
#define kHOffsetSecondLable_voiceImageView        (10)  //水平方向上，秒数Lable和喇叭ImageVIew之间的间隙
#define kHOffsetSecondLable_BubbleView            (20)  //水平方向上，秒数Lable和气泡之间的间隙
#define kHOffsetVoiceImage_BubbleView             (25)  //水平方向上，喇叭和气泡之间的间隔
#define kVOffsetSecondLable_BubbleView            (20)   //垂直方向上，秒数Lable和气泡顶部间隔

//对方秒数Lable 字体颜色
#define kTextColorSecondLable_Receive             ([UIColor blackColor])
#define kTextColorSecondLable_Sender              ([UIColor whiteColor])


@interface WSChatVoiceTableViewCell ()
{    
    /**
     *  @brief  声音秒数
     */
    UILabel   *mSecondLable;
    
    /**
     *  @brief  喇叭
     */
    UIImageView *mVoiceImageView;
}
@end

@implementation WSChatVoiceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(voiceBeenTaped:)];
        [mBubbleImageView addGestureRecognizer:tap];
        
        mSecondLable = [UILabel newAutoLayoutView];
        mSecondLable.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:mSecondLable];
        
        mVoiceImageView = [UIImageView newAutoLayoutView];
        mVoiceImageView.backgroundColor= [UIColor clearColor];
        [self.contentView addSubview:mVoiceImageView];

        CGFloat scale = 0.6;
        [mVoiceImageView autoSetDimensionsToSize:CGSizeMake(29 *scale, 33*scale)];
        mVoiceImageView.animationDuration = 1;
        mVoiceImageView.animationRepeatCount = 0;
        
        if (isSender)
        {
            mSecondLable.textAlignment = NSTextAlignmentRight;
            mSecondLable.textColor = kTextColorSecondLable_Sender;
            [mSecondLable autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:mVoiceImageView withOffset:-kHOffsetSecondLable_voiceImageView];
            [mSecondLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mBubbleImageView withOffset:kHOffsetSecondLable_BubbleView];

            [mSecondLable autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kHMinOffsetSecondLable_supView relation:NSLayoutRelationGreaterThanOrEqual];
            
            mVoiceImageView.image = [UIImage imageNamed:@"chat_voice_sender3"];
            mVoiceImageView.animationImages = @[[UIImage imageNamed:@"chat_voice_sender1"],
                                                [UIImage imageNamed:@"chat_voice_sender2"],
                                                [UIImage imageNamed:@"chat_voice_sender3"]];
            [mVoiceImageView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:mBubbleImageView withOffset:-kHOffsetVoiceImage_BubbleView];
            
            
        }else
        {
            mVoiceImageView.image = [UIImage imageNamed:@"chat_voice_receive3"];
            mVoiceImageView.animationImages = @[[UIImage imageNamed:@"chat_voice_receive1"],
                                                [UIImage imageNamed:@"chat_voice_receive2"],
                                                [UIImage imageNamed:@"chat_voice_receive3"]];
            [mVoiceImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mBubbleImageView withOffset:kHOffsetVoiceImage_BubbleView];
            
            
            mSecondLable.textColor = kTextColorSecondLable_Receive;
            mSecondLable.textAlignment = NSTextAlignmentLeft;
            [mSecondLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mVoiceImageView withOffset:kHOffsetSecondLable_voiceImageView];
            [mSecondLable autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:mBubbleImageView withOffset:-kHOffsetSecondLable_BubbleView];
            [mSecondLable  autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kHMinOffsetSecondLable_supView relation:NSLayoutRelationGreaterThanOrEqual];
        }
        
        
        [mVoiceImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:mSecondLable];
        [mSecondLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mBubbleImageView withOffset:kVOffsetSecondLable_BubbleView];
        [mVoiceImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:mBubbleImageView];
        [mBubbleImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        
    }
    
    return self;
}


-(void)setModel:(WSChatModel *)model
{
    mSecondLable.text = [NSString stringWithFormat:@"%ld'        ",(long)model.secondVoice];
    
    [super setModel:model];
}


-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    if (Press.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
        
        UIMenuItem *remove = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(menuRemove:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[remove]];
        [menu setTargetRect:mBubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return  (action == @selector(menuRemove:));
}


#pragma mark --删除处理

-(void)menuRemove:(id)sender
{
    [self routerEventWithType:EventChatCellRemoveEvent userInfo:@{kModelKey:self.model}];
}


-(void)voiceBeenTaped:(UITapGestureRecognizer*)tap
{
    mVoiceImageView.isAnimating?[mVoiceImageView stopAnimating]:[mVoiceImageView startAnimating];
}

@end
