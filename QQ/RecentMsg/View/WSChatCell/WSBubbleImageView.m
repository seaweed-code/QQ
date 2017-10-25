//
//  WSBubbleImageView.m
//  QQ
//
//  Created by weida on 2017/10/25.
//  Copyright © 2017年 weida. All rights reserved.
//

#import "WSBubbleImageView.h"
@interface WSBubbleImageView(){
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@end



@implementation WSBubbleImageView

- (instancetype)init:(BOOL)isSender
{
    self = [super init];
    if (self) {
        [self setup:isSender];
    }
    return self;
}


- (void)setup:(BOOL)isSender
{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;//非常关键设置自动拉伸的效果且不变形
    
    if (isSender){
        _maskLayer.contents = (id)[[UIImage imageNamed:@"chat_send_imagemask@2x"] stretchableImageWithLeftCapWidth:30 topCapHeight:30].CGImage;
        
    }else{
        _maskLayer.contents = (id)[[UIImage imageNamed:@"chat_recive_imagemask@2x"]stretchableImageWithLeftCapWidth:30 topCapHeight:30].CGImage;
    }
    
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    [self.layer addSublayer:_contentLayer];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _maskLayer.frame = self.bounds;
    _contentLayer.frame = self.bounds;
}



- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}  

@end
