//
//  WSChatTextTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/16.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatTextTableViewCell.h"
#import "PureLayout.h"

//文本
#define kH_OffsetTextWithHead    (20)//水平方向文本和头像的距离
#define kMaxOffsetText           (45)//文本最长时，为了不让文本分行显示，需要和屏幕对面保持一定距离
#define kTop_OffsetTextWithHead  (15) //文本和头像顶部对其间距


@implementation WSChatTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        mTextLable = [UILabel newAutoLayoutView];
        mTextLable.numberOfLines = 0;
        mTextLable.backgroundColor = [UIColor clearColor];
        mTextLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:mTextLable];
        
        [mTextLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mHead withOffset:kTop_OffsetTextWithHead];
        [mTextLable setContentHuggingPriority:UILayoutPriorityDefaultLow+1 forAxis:UILayoutConstraintAxisHorizontal];
        
        if (isSender)//是自己发送的消息
        {
            [mTextLable autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:mHead withOffset:-kH_OffsetTextWithHead];
           // mTextLable.textAlignment = NSTextAlignmentRight;
            [mTextLable autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kMaxOffsetText relation:NSLayoutRelationGreaterThanOrEqual];
            
        }else//是对方发送的消息
        {
            [mTextLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mHead withOffset:kH_OffsetTextWithHead];
           // mTextLable.textAlignment = NSTextAlignmentLeft;
            [mTextLable autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kMaxOffsetText relation:NSLayoutRelationGreaterThanOrEqual];
        }

        
    }
    return self;
}



-(void)setModel:(WSChatModel *)model
{
    [super setModel:model];
   
    mTextLable.text = model.content;
    
    [self layoutIfNeeded];
    
    CGRect rect = mTextLable.frame;
    
    mWidthConstraintBubbleImageView.constant = rect.size.width+40;
    mHeightConstraintBubbleImageView.constant = rect.size.height +45;
    
    if (model.isSender)
    {
        mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_send_nor] stretchableImageWithLeftCapWidth:35 topCapHeight:40];
        
    }else
    {
         mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_Recieve_nor]stretchableImageWithLeftCapWidth:35 topCapHeight:40];
    }
    
   //  NSLog(@"---%@",NSStringFromCGRect(mTextLable.frame));
}

@end
