//
//  WSChatVoiceTableViewCell.m
//  QQ
//
//  Created by weida on 15/9/22.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatVoiceTableViewCell.h"


#define kMinOffsetSecondLable_supView            (40)  //秒数Lable和父控件之间的最小间隙
#define kOffsetSecondLable_voiceImageView        (10)  //秒数Lable和喇叭ImageVIew之间的间隙
#define kOffsetSecondLable_BubbleView            (20)  //秒数Lable和气泡之间的间隙



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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageBeenTaped:)];
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
            [mSecondLable autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:mVoiceImageView withOffset:-kOffsetSecondLable_voiceImageView];
            [mSecondLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mBubbleImageView withOffset:kOffsetSecondLable_BubbleView];

            [mSecondLable autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kMinOffsetSecondLable_supView relation:NSLayoutRelationGreaterThanOrEqual];
            
            mVoiceImageView.image = [UIImage imageNamed:@"chat_voice_sender3"];
            mVoiceImageView.animationImages = @[[UIImage imageNamed:@"chat_voice_sender1"],
                                                [UIImage imageNamed:@"chat_voice_sender2"],
                                                [UIImage imageNamed:@"chat_voice_sender3"]];
            [mVoiceImageView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:mBubbleImageView withOffset:-20];
            
            
        }else
        {
            mVoiceImageView.image = [UIImage imageNamed:@"chat_voice_receive3"];
            mVoiceImageView.animationImages = @[[UIImage imageNamed:@"chat_voice_receive1"],
                                                [UIImage imageNamed:@"chat_voice_receive2"],
                                                [UIImage imageNamed:@"chat_voice_receive3"]];
            [mVoiceImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mBubbleImageView withOffset:20];
            
            
            [mSecondLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mVoiceImageView withOffset:kOffsetSecondLable_voiceImageView];
            [mSecondLable autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:mBubbleImageView withOffset:-kOffsetSecondLable_BubbleView];
            [mSecondLable  autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kMinOffsetSecondLable_supView relation:NSLayoutRelationGreaterThanOrEqual];
        }
        
        
        [mVoiceImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:mSecondLable];
        [mSecondLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mBubbleImageView withOffset:20];
        [mVoiceImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:mBubbleImageView];
        [mBubbleImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:0];
        
    }
    
    return self;
}


-(void)setModel:(WSChatModel *)model
{
    mSecondLable.text = [NSString stringWithFormat:@"%d'        ",model.secondVoice];
    
    [super setModel:model];
}


-(void)imageBeenTaped:(UITapGestureRecognizer*)tap
{
    mVoiceImageView.isAnimating?[mVoiceImageView stopAnimating]:[mVoiceImageView startAnimating];
}

@end
