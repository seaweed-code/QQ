//
//  WSChatImageTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/17.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatImageTableViewCell.h"
#import "PureLayout.h"
#import "UIImageView+WebCache.h"
#import "WSBubbleImageView.h"

#define kMinWidthImageView             (20)
#define kMinHeightImageView            (30)
#define kMaxHeightImageView            (140)
//#define kMinTraingImageViewSupView     (60)//图片与父视图右侧最小间距

@interface WSChatImageTableViewCell ()
@end


@implementation WSChatImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [mBubbleImageView removeFromSuperview];
        mBubbleImageView = nil;
        mBubbleImageView = [[WSBubbleImageView alloc]init:isSender];
        mBubbleImageView.backgroundColor = [UIColor clearColor];
        mBubbleImageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *bubblelongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [mBubbleImageView addGestureRecognizer:bubblelongPress];
        [self.contentView addSubview:mBubbleImageView];
    }
    
    return self;
}

+(CGSize)calculateImageModelSize:(WSChatModel*)model width:(CGFloat)width{
    NSArray *arry = [model.content componentsSeparatedByString:@","];
    CGFloat wOriginal = [arry[0] floatValue];
    CGFloat hOriginal = [arry[1] floatValue];
    CGFloat h,w = wOriginal;
    
    if (wOriginal < kMinWidthImageView) {
        w = kMinWidthImageView;
    }
    
    CGFloat minTraingImageViewSuperView = width*.5;
    
    CGFloat xBubble = kLeadingHead+kWidthHead+kOffsetHHeadToBubble;
    if (xBubble + wOriginal + minTraingImageViewSuperView > width) {
        w = width - xBubble - minTraingImageViewSuperView;
    }

    h = (hOriginal/wOriginal)*w;
    
    if (h < kMinHeightImageView){
        h = kMinHeightImageView;
    }
    
    if (h > kMaxHeightImageView){
        h = kMaxHeightImageView;
    }
    
    return CGSizeMake(w, h);
}

+(NSDictionary *)calculateSubViewsFramewithModel:(WSChatModel *)model width:(CGFloat)width
{
    NSMutableDictionary *superDict = [super calculateSubViewsFramewithModel:model width:width].mutableCopy;
    if (superDict && model) {
       
        CGFloat xBubble = kLeadingHead+kWidthHead+kOffsetHHeadToBubble;
        CGFloat yBubble = kTopHead+kOffsetTopHeadToBubble;
        CGSize  size = [self calculateImageModelSize:model width:width];
        CGFloat widthBubble  = size.width;
        CGFloat heightBubble = size.height;
        
        
        if ([model.isSender boolValue]) {
            [superDict setObject:[NSValue valueWithCGRect:CGRectMake(width - xBubble - widthBubble, yBubble, widthBubble, heightBubble)] forKey:@"mBubbleImageView"];
        }else{
            [superDict setObject:[NSValue valueWithCGRect:CGRectMake(xBubble, yBubble, widthBubble, heightBubble)] forKey:@"mBubbleImageView"];
        }
    
        [superDict setObject:@(heightBubble+2*yBubble) forKey:@"height"];
        
        return @{@(width):superDict};
        
    }
    return nil;
}

-(void)setModel:(WSChatModel *)model width:(CGFloat)width{
    
    if (model.sendingImage)
    {
        mBubbleImageView.image = model.sendingImage;
    }else
    {
        [mBubbleImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:[UIImage imageNamed:@"leftMenuBk"]];
    }
    
    [super setModel:model width:width];
}


-(void)imageBeenTaped:(UITapGestureRecognizer*)tap
{
    [self routerEventWithType:EventChatCellImageTapedEvent userInfo:@{kModelKey:model}];
}

-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    if (Press.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
        
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuCopy:)];
        UIMenuItem *remove = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(menuRemove:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[copy,remove]];
        [menu setTargetRect:mBubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return  ((action == @selector(menuCopy:))  || (action == @selector(menuRemove:)));
}


#pragma mark --复制、删除处理
-(void)menuCopy:(id)sender
{
   // [UIPasteboard generalPasteboard].image = mImageView.image;
}

-(void)menuRemove:(id)sender
{
    [self routerEventWithType:EventChatCellRemoveEvent userInfo:@{kModelKey:model}];
}

@end
