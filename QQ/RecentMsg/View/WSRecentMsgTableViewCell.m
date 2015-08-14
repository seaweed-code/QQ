//
//  WSRecentMsgTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/14.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSRecentMsgTableViewCell.h"
#import "PureLayout.h"

#define kWidhtHeadImageView   (45)

#define kTextColorSubTitle    ([UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1])

#define kBkColorLine          ([UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:1])

#define kTextColorTime        ([UIColor colorWithRed:0.741 green:0.741 blue:0.741 alpha:1])

@interface WSRecentMsgTableViewCell ()
{
    /**
     *  @brief  头部图片
     */
    UIImageView *mHeadView;
    
    /**
     *  @brief  好友名称
     */
    UILabel     *mTitle;
    
    /**
     *  @brief  聊天详情
     */
    UILabel     *mSubTitle;
    
    /**
     *  @brief  时间
     */
    UILabel     *mTime;
}
@end

@implementation WSRecentMsgTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setupSubViews];
    }
    
    return self;
}

/**
 *  @brief  设置子控件
 */
-(void)setupSubViews
{
    mHeadView = [UIImageView newAutoLayoutView];
    mHeadView.image = [UIImage imageNamed:@"user_avatar_default"];
    [self.contentView addSubview:mHeadView];
    
    [mHeadView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [mHeadView  autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [mHeadView autoSetDimensionsToSize:CGSizeMake(kWidhtHeadImageView, kWidhtHeadImageView)];
    
    
    mTitle = [UILabel newAutoLayoutView];
    mTitle.font = [UIFont systemFontOfSize:14];
    mTitle.text = @"快手技术部";
    [self.contentView addSubview:mTitle];
    
    [mTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mHeadView withOffset:5];
    [mTitle autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mHeadView withOffset:10];
    
    
    mSubTitle = [UILabel newAutoLayoutView];
    mSubTitle.font = [UIFont systemFontOfSize:12];
    mSubTitle.text = @"吃饭了么";
    mSubTitle.textColor = kTextColorSubTitle;
    [self.contentView addSubview:mSubTitle];
    
    UIView *line = [UIView newAutoLayoutView];
    line.backgroundColor= kBkColorLine;
    [self.contentView addSubview:line];
    [line autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mSubTitle];
    [line autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.contentView];
    [line autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:-1];
    [line autoSetDimension:ALDimensionHeight toSize:1];
    
    
    [mSubTitle autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mTitle];
    [mSubTitle  autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:mHeadView withOffset:-5];
    
    
    mTime = [UILabel newAutoLayoutView];
    mTitle.textAlignment = NSTextAlignmentRight;
    mTime.text = @"下午9:20";
    mTime.textColor = kTextColorTime;
    mTime.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:mTime];
    
    [mTime autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mTitle];
    [mTime autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [mTime autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mTitle withOffset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
