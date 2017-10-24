//
//  WSChatTableBaseCell.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatBaseTableViewCell.h"


@implementation WSChatBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        mHead = [[UIImageView alloc]init];
        mHead.backgroundColor = [UIColor clearColor];
        mHead.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headBeenTaped:)];
        [mHead addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *headlongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(headBeenLongPress:)];
        [mHead addGestureRecognizer:headlongPress];
        
        mHead.image = [UIImage imageNamed:@"user_avatar_default"];
        [self.contentView addSubview:mHead];
      
        
        mBubbleImageView = [[UIImageView alloc]init];
        mBubbleImageView.backgroundColor = [UIColor clearColor];
        mBubbleImageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *bubblelongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [mBubbleImageView addGestureRecognizer:bubblelongPress];
        [self.contentView addSubview:mBubbleImageView];
        
    
        NSArray *IDs = [reuseIdentifier componentsSeparatedByString:kReuseIDSeparate];
        
        NSAssert(IDs.count>=2, @"reuseIdentifier should be separate by -");
       
        isSender = [IDs[0] boolValue];
        
        if (isSender){
            mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_send_nor] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            mBubbleImageView.highlightedImage = [[UIImage imageNamed:kImageNameChat_send_press] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            
        }else{
            mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_Recieve_nor]stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            mBubbleImageView.highlightedImage = [[UIImage imageNamed:kImageNameChat_Recieve_press] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        }
    }
    
    return self;
}

+(NSDictionary *)calculateSubViewsFramewithModel:(WSChatModel *)model width:(CGFloat)width
{
    if (model && [model.isSender boolValue]) {
        return  @{@"mHead":[NSValue valueWithCGRect:CGRectMake(width-kTraingHead-kWidthHead, kTopHead, kWidthHead, kHeightHead)]};
    }
    
    if (model && ![model.isSender boolValue]) {
        return  @{@"mHead":[NSValue valueWithCGRect:CGRectMake(kLeadingHead, kTopHead, kWidthHead, kHeightHead)]};
    }
    
    return nil;
}

-(void)setModel:(WSChatModel *)model width:(CGFloat)width{
    NSDictionary *frame = model.subViewsFrame[@(width)];
    if (frame && [frame isKindOfClass:[NSDictionary class]]) {
        NSValue *value = frame[@"mHead"];
        mHead.frame = [value CGRectValue];
        
        value = frame[@"mBubbleImageView"];
        mBubbleImageView.frame = [value CGRectValue];
        
        model = model;
    }else{
        [model calculateSubViewsFrame:width];
        [self setModel:model width:width];
    }
}


-(void)headBeenTaped:(UITapGestureRecognizer *)tap
{
    [self routerEventWithType:EventChatCellHeadTapedEvent userInfo:@{kModelKey:model}];
}

-(void)headBeenLongPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        [self routerEventWithType:EventChatCellHeadLongPressEvent userInfo:@{kModelKey:model}];
    }
   
}

-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    NSLog(@"subClass Must Override this Method");
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
