//
//  WSChatTimeTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/16.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTimeTableViewCell.h"
#import "WSChatModel.h"


#define kTextColorTime      ([UIColor colorWithRed:0.341 green:0.369 blue:0.357 alpha:1])

#define kTopOffsetTime      (20)//Time Lable和父控件顶部间距
#define kLeadingOffetTime   (20)//Time Lable和父控件右侧最小间距

#define kFontTimeLable     ([UIFont systemFontOfSize:10])

@interface WSChatTimeTableViewCell ()
{
    UILabel *mTimeLable;
}
@end

@implementation WSChatTimeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        mTimeLable = [[UILabel alloc]init];
        mTimeLable.backgroundColor =[UIColor clearColor];
        mTimeLable.font = kFontTimeLable;
        mTimeLable.textColor = kTextColorTime;
        mTimeLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:mTimeLable];
        
    }
    
    return self;
}

+(NSDictionary *)calculateSubViewsFramewithModel:(WSChatModel *)model width:(CGFloat)width{
    
    if (model) {
         CGRect textRect = [model.timeStamp.description boundingRectWithSize:CGSizeMake(width-kLeadingOffetTime*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFontTimeLable} context:nil];
        
        return @{@(width):@{@"mTimeLable":[NSValue valueWithCGRect:CGRectMake((width-textRect.size.width)*0.5, kTopOffsetTime,textRect.size.width,textRect.size.height)],@"height":@(kTopOffsetTime*2+textRect.size.height)}};
    }
    
    
    return nil;
}

-(void)setModel:(WSChatModel *)model width:(CGFloat)width{
    mTimeLable.text = model.timeStamp.description;
    
    NSDictionary *frame = model.subViewsFrame[@(width)];
    if (frame && [frame isKindOfClass:[NSDictionary class]]) {
        NSValue *value = frame[@"mTimeLable"];
        mTimeLable.frame = [value CGRectValue];
    }
}

@end
