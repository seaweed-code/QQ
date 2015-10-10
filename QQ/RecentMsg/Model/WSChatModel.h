//
//  WSChatModel.h
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <Foundation/Foundation.h>

#define kCellReuseIDWithSenderAndType(isSender,chatCellType)    ([NSString stringWithFormat:@"%d-%ld",isSender,chatCellType])

//根据模型得到可重用Cell的 重用ID
#define kCellReuseID(model)      ((model.chatCellType == WSChatCellType_Time)?kTimeCellReusedID:(kCellReuseIDWithSenderAndType(model.isSender,(long)model.chatCellType)))


/**
 *  @brief  消息类型
 */
typedef NS_OPTIONS(NSInteger,WSChatCellType)
{
    /**
     *  @brief  文本消息
     */
    WSChatCellType_Text = 1,
    
    /**
     *  @brief  图片消息
     */
    WSChatCellType_Image = 2,

    /**
     *  @brief  语音消息
     */
    WSChatCellType_Audio = 3,

    /**
     *  @brief  视频消息
     */
    WSChatCellType_Video = 4,
    
    /**
     *  @brief  时间
     */
    WSChatCellType_Time  = 0
};


@interface WSChatModel : NSObject

/**
 *  @brief  本条消息是否本人发送？
 */
@property(nonatomic,assign) BOOL isSender;

/**
 *  @brief  本消息类型？文本？图片？还是语音？
 */
@property(nonatomic,assign)WSChatCellType chatCellType;

/**
 *  @brief  消息内容
 */
@property(nonatomic,strong)id  content;

/**
 *  @brief  信息发送者头像
 */
@property(nonatomic,strong)NSString *headImageURL_sender;

/**
 *  @brief  声音秒数
 */
@property(nonatomic,assign)NSInteger  secondVoice;

/**
 *  @brief  Cell的高度,默认是0
 */
@property(nonatomic,assign)NSInteger  height;
@end




