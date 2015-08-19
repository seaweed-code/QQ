//
//  WSChatTableBaseCell.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatBaseTableViewCell.h"
#import "UIImage+Utils.h"




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


-(void)setModel:(WSChatModel *)model
{
    _model = model;
    
}

-(void)setBubbeView:(CGSize) size
{
    
    if (isSender)
    {
        mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_send_nor] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        
    }else
    {
        mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_Recieve_nor]stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    }
    
    
    switch (self.model.chatCellType)
    {
        case WSChatCellType_Text:
            
            mWidthConstraintBubbleImageView.constant = size.width  +40;
            mHeightConstraintBubbleImageView.constant = size.height +40;

            break;
        case WSChatCellType_Image:
        case WSChatCellType_Video:
        {
            mWidthConstraintBubbleImageView.constant = size.width;
            mHeightConstraintBubbleImageView.constant = size.height;
         
         
            UIImageView *imageView = (UIImageView*)mContentView;

            
            const UIImage *maskImageDrawnToSize = [mBubbleImageView.image renderAtSize:size];
            
            imageView.image = [[UIImage imageNamed:self.model.content] maskWithImage:maskImageDrawnToSize];
            
        }
            break;
        default:
            
            break;
    }


}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:@"bounds"])
        return;
    
    CGRect newRect = [change[@"new"] CGRectValue];
    
    NSLog(@"change:%@",NSStringFromCGRect(newRect));
    
    [self setBubbeView:newRect.size];
    
    
}
-(void)dealloc
{
    [mContentView removeObserver:self forKeyPath:@"bounds"];
}


@end
