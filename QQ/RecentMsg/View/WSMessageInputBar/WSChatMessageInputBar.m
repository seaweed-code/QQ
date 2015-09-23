//
//  WSChatMessageInputBar.m
//  QQ
//
//  Created by weida on 15/9/23.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatMessageInputBar.h"
#import "PureLayout.h"

@interface WSChatMessageInputBar ()
{
    

    /**
     *  @brief  自己高度的约束
     */
    NSLayoutConstraint *mHeightConstraint;
}


/**
 *  @brief  输入TextView
 */
@property(nonatomic,strong)UITextView *mInputTextView;

@end

@implementation WSChatMessageInputBar

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.mInputTextView];
        
        [self.mInputTextView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        
        self.backgroundColor = [UIColor whiteColor];
      
        mHeightConstraint = [self autoSetDimension:ALDimensionHeight toSize:40];
    }
    return self;
}


#pragma mark - Getter Method

-(UITextView *)mInputTextView
{
    if (_mInputTextView) {
        return _mInputTextView;
    }
    
    _mInputTextView = [[UITextView alloc]initForAutoLayout];
    
    _mInputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f);
    _mInputTextView.contentInset = UIEdgeInsetsZero;
    _mInputTextView.scrollEnabled = YES;
    _mInputTextView.scrollsToTop = NO;
    _mInputTextView.userInteractionEnabled = YES;
    _mInputTextView.font = [UIFont systemFontOfSize:16.0f];
    _mInputTextView.textColor = [UIColor blackColor];
    _mInputTextView.backgroundColor = [UIColor whiteColor];
    _mInputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    _mInputTextView.keyboardType = UIKeyboardTypeDefault;
    _mInputTextView.returnKeyType = UIReturnKeyDefault;
    _mInputTextView.textAlignment = NSTextAlignmentLeft;
    
    return _mInputTextView;
}


@end
