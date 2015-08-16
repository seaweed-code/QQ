//
//  WSChatTableBaseCell.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatBaseTableViewCell.h"


#define kWidthHead             (40)  //头像宽度
#define kHeightHead            (kWidthHead) //头像高度
#define kTopHead               (10)  //头像离父视图顶部距离
#define kLeadingHead           (10) //对方发送的消息时，头像距离父视图的leading(头像在左边)
#define kTraingHead            (kLeadingHead) //自己发送的消息时，头像距离父视图的traing(头像在右边)

#define kOffsetHHeadToBubble    (0) //头像和气泡水平距离

#define kOffsetTopHeadToBubble  (5)  //头像和气泡顶部对其间距



@implementation WSChatBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        mHead = [UIImageView newAutoLayoutView];
        mHead.image = [UIImage imageNamed:@"user_avatar_default"];
        [self.contentView addSubview:mHead];
      
        [mHead autoSetDimensionsToSize:CGSizeMake(kWidthHead, kHeightHead)];
        
        [mHead autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kTopHead];
        NSArray *IDs = [reuseIdentifier componentsSeparatedByString:kReuseIDSeparate];
        
        NSAssert(IDs.count>=2, @"reuseIdentifier should be separate by -");
        
        isSender = [IDs[0] boolValue];
        
        if (isSender)//是我自己发送的
        {
            [mHead autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kTraingHead];
        }else//别人发送的消息
        {
            [mHead autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLeadingHead];
        }
        
        mBubbleImageView = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:mBubbleImageView];
        
        [mBubbleImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mHead withOffset:-kOffsetTopHeadToBubble];
        [mBubbleImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        if (isSender)//是我自己发送的
        {
            [mBubbleImageView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:mHead withOffset:-kOffsetHHeadToBubble];
        }else//别人发送的消息
        {
            [mBubbleImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mHead withOffset:kOffsetHHeadToBubble];
        }
        
       mWidthConstraintBubbleImageView  = [mBubbleImageView autoSetDimension:ALDimensionWidth toSize:64];
       mHeightConstraintBubbleImageView = [mBubbleImageView autoSetDimension:ALDimensionHeight toSize:56];

    }
    
    return self;
}




@end
