//
//  WSChatTableViewController+MoreViewClick.h
//  QQ
//
//  Created by weida on 16/1/22.
//  Copyright © 2016年 weida. All rights reserved.
//

#import "WSChatTableViewController.h"

@interface WSChatTableViewController (MoreViewClick)

/**
 *  @author weida
 *
 *  @brief 从相册列表选择图片
 *
 *  @param maxCount 最多选择几张
 */
-(void)pickerImages:(NSInteger)maxCount;

@end
