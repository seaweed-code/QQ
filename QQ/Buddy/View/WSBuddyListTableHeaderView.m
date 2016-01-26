//
//  WSBuddyListTableHeaderView.m
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//

#import "WSBuddyListTableHeaderView.h"

#define kBkColorLine          ([UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:1])

@interface WSBuddyListTableHeaderView ()
{
    CALayer *_line;
    
    CALayer *_image;
    
    UILabel *_groupName;
    
    UILabel *_totalCount;
    
    UIButton *_button;
}
@end


@implementation WSBuddyListTableHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _line = [[CALayer alloc]init];
        _line.backgroundColor = kBkColorLine.CGColor;
        [self.contentView.layer addSublayer:_line];
     
        _image = [[CALayer alloc]init];
        _image.backgroundColor = [UIColor clearColor].CGColor;
        _image.contents = (__bridge id _Nullable)([UIImage imageNamed:@"buddy_header_arrow"].CGImage);
        [self.contentView.layer addSublayer:_image];
        
        
        _groupName = [[UILabel alloc]init];
        _groupName.backgroundColor = [UIColor clearColor];
        _groupName.font = [UIFont systemFontOfSize:14];
        [self.contentView.layer addSublayer:_groupName.layer];

        _totalCount = [[UILabel alloc]init];
        _totalCount.backgroundColor = [UIColor clearColor];
        _totalCount.font = [UIFont systemFontOfSize:10];
        [self.contentView.layer addSublayer:_totalCount.layer];
        
        _button = [[UIButton alloc]init];
        [_button addTarget:self action:@selector(showGroup:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _line.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
    
    CGFloat x     = 10;
    CGFloat width = 7;
    CGFloat height = 11;
    _image.frame = CGRectMake(x,(self.bounds.size.height-height)/2,width,height);
    
    x += CGRectGetMaxX(_image.frame);
    _groupName.frame = CGRectMake(x, 0, self.bounds.size.width/2 , self.bounds.size.height);
    
    width = 40;
    _totalCount.frame = CGRectMake(self.bounds.size.width-width, 0,width, self.bounds.size.height);
    
    _button.frame = self.contentView.bounds;
    
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    _image.transform = CATransform3DIdentity;//防止变形
}

#pragma mark - 事件处理

-(void)showGroup:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.5 animations:^
    {
        if (sender.selected) {
            _image.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
        }else {
            _image.transform = CATransform3DIdentity;
        }
    }];
    
}

-(void)setSectionInfo:(id<NSFetchedResultsSectionInfo>)sectionInfo
{
    _sectionInfo = sectionInfo;
     _totalCount.text = [sectionInfo indexTitle];
    _groupName.text = [sectionInfo name];
}

@end
