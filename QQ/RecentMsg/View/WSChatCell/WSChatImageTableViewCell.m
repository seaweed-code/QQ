//
//  WSChatImageTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/17.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatImageTableViewCell.h"
#import "PureLayout.h"
#import "UIImage+Utils.h"

//文本
#define kH_OffsetTextWithHead        (20)//水平方向文本和头像的距离
#define kMaxOffsetText               (45)//文本最长时，为了不让文本分行显示，需要和屏幕对面保持一定距离
#define kTop_OffsetTextWithHead      (15) //文本和头像顶部对其间距
#define kBottom_OffsetTextWithSupView   (40)//文本与父视图底部间距

#define kMaxHeightImageView            (200)


@implementation WSChatImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        mImageView = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:mImageView];
        mContentView = mImageView;
        
        
        [mContentView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        CGFloat top     =  kTopHead - kOffsetTopHeadToBubble;
        
        CGFloat bottom  = kBottom_OffsetTextWithSupView;
        
        CGFloat leading = kOffsetHHeadToBubble + kWidthHead + kLeadingHead;
        CGFloat traing  = kMaxOffsetText;
        
        [mImageView autoSetDimension:ALDimensionHeight toSize:kMaxHeightImageView relation:NSLayoutRelationLessThanOrEqual];
        
        UIEdgeInsets inset;
        if (isSender)//是自己发送的消息
        {
            inset = UIEdgeInsetsMake(top, traing, bottom, leading);
            
            [mImageView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeLeading];
            
            [mImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
            
        }else//是对方发送的消息
        {
            inset = UIEdgeInsetsMake(top, leading, bottom, traing);
            
            [mImageView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTrailing];
            
            [mImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
        }

        
    }
    
    return self;
}

-(void)setModel:(WSChatModel *)model
{
    UIImage *image = [UIImage imageNamed:model.content];
  
    mImageView.image = image;
    
    if (mImageView.frame.size.height && mImageView.frame.size.width)
    {
        const UIImage *maskImageDrawnToSize = [mBubbleImageView.image renderAtSize:mImageView.frame.size];
        
        mImageView.image = [image maskWithImage:maskImageDrawnToSize];
    }
    
    [super setModel:model];
}


-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    if (Press.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
        
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuCopy:)];
        UIMenuItem *remove = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(menuRemove:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[copy,remove]];
        [menu setTargetRect:mBubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return  ((action == @selector(menuCopy:))  || (action == @selector(menuRemove:)));
}


#pragma mark --复制、删除处理
-(void)menuCopy:(id)sender
{
    [UIPasteboard generalPasteboard].image = mImageView.image;
}

-(void)menuRemove:(id)sender
{
    [self routerEventWithName:kRouterEventChatCellRemoveEventName userInfo:@{kModelKey:self.model}];
}

@end
