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
#define kH_OffsetTextWithHead        (20)//水平方向文本和头像的距离
#define kMaxOffsetText               (45)//文本最长时，为了不让文本分行显示，需要和屏幕对面保持一定距离
#define kTop_OffsetTextWithHead      (15) //文本和头像顶部对其间距
#define kBottom_OffsetTextWithSupView   (40)//文本与父视图底部间距

@implementation WSChatTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        mTextLable = [UILabel newAutoLayoutView];
        mContentView = mTextLable;
        mTextLable.numberOfLines = 0;
        mTextLable.backgroundColor = [UIColor clearColor];
        mTextLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:mTextLable];
        
        
         [mContentView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        CGFloat top     = kTop_OffsetTextWithHead + kTopHead;
        CGFloat bottom  = kBottom_OffsetTextWithSupView;
        
        CGFloat leading = kH_OffsetTextWithHead + kWidthHead + kLeadingHead;
        CGFloat traing  = kMaxOffsetText;
        
        UIEdgeInsets inset;
        if (isSender)//是自己发送的消息
        {
            inset = UIEdgeInsetsMake(top, traing, bottom, leading);
            
            [mTextLable autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeLeading];
            
            [mTextLable autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
            
        }else//是对方发送的消息
        {
            inset = UIEdgeInsetsMake(top, leading, bottom, traing);
            
            [mTextLable autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTrailing];
            
            [mTextLable autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
        }

    }
    return self;
}



-(void)setModel:(WSChatModel *)model
{
    mTextLable.text = model.content;
    
    
    [super setModel:model];
}



@end
