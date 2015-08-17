//
//  WSChatTableBaseCell.h
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSChatModel.h"
#import "PureLayout.h"

#define kReuseIDSeparate       (@"-") //可重用ID字符串区分符号

#define kImageNameChat_send_nor     (@"chat_send_nor")
#define kImageNameChat_Recieve_nor  (@"chat_recive_nor")





@interface WSChatBaseTableViewCell : UITableViewCell
{
    @protected
    
    /**
     *  @brief  头像
     */
    UIImageView *mHead;
    
    /**
     *  @brief  汽包
     */
    UIImageView *mBubbleImageView;
    
    /**
     *  @brief  mBubbleImageView的宽度约束
     */
    NSLayoutConstraint *mWidthConstraintBubbleImageView;
    
    /**
     *  @brief  mBubbleImageView的高度约束
     */
    NSLayoutConstraint *mHeightConstraintBubbleImageView;

    /**
     *  @brief  本消息是否是本人发送的？
     */
    BOOL isSender;
    
    /**
     *  @brief  主要内容视图
     */
    UIView *mContentView;
}
/**
 *  @brief  聊天消息中单条消息模型
 */
@property(nonatomic,strong) WSChatModel *model;


@end
