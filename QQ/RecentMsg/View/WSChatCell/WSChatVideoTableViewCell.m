//
//  WSChatVideoTableViewCell.m
//  QQ
//
//  Created by weida on 2017/10/25.
//  Copyright © 2017年 weida. All rights reserved.
//

#import "WSChatVideoTableViewCell.h"

@implementation WSChatVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
    
    }
    
    return self;
}

+(NSDictionary *)calculateSubViewsFramewithModel:(WSChatModel *)model width:(CGFloat)width
{
    NSDictionary *superDict = [super calculateSubViewsFramewithModel:model width:width];
    
    return superDict;
}

@end
