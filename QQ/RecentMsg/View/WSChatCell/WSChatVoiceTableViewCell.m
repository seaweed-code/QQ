//
//  WSChatVoiceTableViewCell.m
//  QQ
//
//  Created by weida on 15/9/22.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatVoiceTableViewCell.h"

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
        mSecondLable = [UILabel newAutoLayoutView];
        [self.contentView addSubview:mSecondLable];
        
        
        mVoiceImageView = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:mVoiceImageView];
        
    }
    
    return self;
}


-(void)setModel:(WSChatModel *)model
{
    
    
    [super setModel:model];
}

@end
