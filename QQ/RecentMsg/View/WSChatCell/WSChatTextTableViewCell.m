//
//  WSChatTextTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/16.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTextTableViewCell.h"
#import "PureLayout.h"
//文本
#define kH_OffsetTextWithHead        (20)//水平方向文本和头像的距离
#define kMaxOffsetText               (45)//文本最长时，为了让文本分行显示，需要和屏幕对面保持一定距离
#define kTop_OffsetTextWithHead      (15) //文本和头像顶部对其间距
#define kBottom_OffsetTextWithSupView   (40)//文本与父视图底部间距

#define kFontText  ([UIFont systemFontOfSize:14])

#define kLeadingBubble_Text  (20)//气泡和文本的水平间距
#define kTopBubble_Text     (20)//气泡和文本竖直间距
#define kBottomBubble_Super  (10)

@interface WSChatTextTableViewCell ()
{
    /**
     *  @brief  文本Lable
     */
    UILabel *mTextLable;
}
@end

@implementation WSChatTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        mTextLable = [[UILabel alloc]init];
        mTextLable.numberOfLines = 0;
        mTextLable.backgroundColor = [UIColor clearColor];
        mTextLable.font = kFontText;
        [self.contentView addSubview:mTextLable];
    }
    return self;
}

-(void)setModel:(WSChatModel *)model width:(CGFloat)width{
    mTextLable.text = model.content;
    
    NSDictionary *frame = model.subViewsFrame[@(width)];
    if (frame && [frame isKindOfClass:[NSDictionary class]]) {
        NSValue *value = frame[@"mBubbleImageView"];
        mBubbleImageView.frame = [value CGRectValue];
        
        value = frame[@"mTextLable"];
        mTextLable.frame = [value CGRectValue];
    }
    
    [super setModel:model width:width];
}


+(NSDictionary *)calculateSubViewsFramewithModel:(WSChatModel *)model width:(CGFloat)width{
    NSMutableDictionary *superDict = [super calculateSubViewsFramewithModel:model width:width].mutableCopy;
    
    if (superDict && model) {
        NSString *text = model.content;
        CGRect textRect = [text boundingRectWithSize:CGSizeMake(width-kMaxOffsetText-kWidthHead-kOffsetHHeadToBubble-kLeadingHead-kLeadingBubble_Text*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFontText} context:nil];
        
        
        CGFloat yText = kTopHead+kOffsetTopHeadToBubble+kTopBubble_Text;
        CGFloat heightBubble = textRect.size.height+2*kTopBubble_Text;
        superDict[@"height"] = @(kTopHead+kOffsetTopHeadToBubble + heightBubble + kBottomBubble_Super);
        
         CGFloat widthBubble = textRect.size.width+2*kLeadingBubble_Text;
        
        if ([model.isSender boolValue]) {
            
            [superDict setObject:[NSValue valueWithCGRect:CGRectMake(width-(kLeadingHead+kWidthHead+kOffsetHHeadToBubble+kLeadingBubble_Text+textRect.size.width), yText, textRect.size.width, textRect.size.height)] forKey:@"mTextLable"];
            
           
            [superDict setObject:[NSValue valueWithCGRect:CGRectMake(width-(kLeadingHead+kWidthHead+kOffsetHHeadToBubble+widthBubble), kTopHead+kOffsetTopHeadToBubble,widthBubble, heightBubble)] forKey:@"mBubbleImageView"];
           
            
        }else{
            
             [superDict setObject:[NSValue valueWithCGRect:CGRectMake(kLeadingHead+kWidthHead+kOffsetHHeadToBubble+kLeadingBubble_Text, yText, textRect.size.width, textRect.size.height)] forKey:@"mTextLable"];
            
           
             [superDict setObject:[NSValue valueWithCGRect:CGRectMake(kLeadingHead+kWidthHead+kOffsetHHeadToBubble, kTopHead+kOffsetTopHeadToBubble, widthBubble, heightBubble)] forKey:@"mBubbleImageView"];
            
           
        }
        
        return @{@(width):superDict};
    }
    
    return nil;
}


-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    if (Press.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
        
        mBubbleImageView.highlighted = YES;
        
    
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuCopy:)];
        UIMenuItem *retweet = [[UIMenuItem alloc]initWithTitle:@"转发" action:@selector(menuRetweet:)];
        UIMenuItem *retweetMultiple = [[UIMenuItem alloc]initWithTitle:@"转发多条" action:@selector(menuRetweetMultiple:)];
        UIMenuItem *remove = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(menuRemove:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[copy,retweet,retweetMultiple,remove]];
        [menu setTargetRect:mBubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIMenuControllerWillHideMenu) name:UIMenuControllerWillHideMenuNotification object:nil];
        
    }
}

/**
 *  @brief  菜单隐藏时调用此方法
 */
-(void)UIMenuControllerWillHideMenu
{
    mBubbleImageView.highlighted = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return  ((action == @selector(menuCopy:))   || (action == @selector(menuRemove:))  ||
            (action == @selector(menuRetweet:)) || (action == @selector(menuRetweetMultiple:)));
}


#pragma mark --复制、删除、转发、转发多条
-(void)menuCopy:(id)sender
{
    [UIPasteboard generalPasteboard].string = mTextLable.text;
    
}


-(void)menuRetweet:(id)sender
{
    
}

-(void)menuRetweetMultiple:(id)sender
{
   
}

-(void)menuRemove:(id)sender
{
    [self routerEventWithType:EventChatCellRemoveEvent userInfo:@{kModelKey:model}];
}


@end
