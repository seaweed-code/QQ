//
//  WSChatMessageInputBar.m
//  QQ
//
//  Created by weida on 15/9/23.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatMessageInputBar.h"
#import "PureLayout.h"

//背景颜色
#define kBkColor               ([UIColor colorWithRed:0.922 green:0.925 blue:0.929 alpha:1])

//每个btn之间间隔
//#define kHOffsetBtn            (4)

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
        self.backgroundColor = kBkColor;
        mHeightConstraint = [self autoSetDimension:ALDimensionHeight toSize:40];
        
        UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        voiceBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        voiceBtn.backgroundColor = [UIColor clearColor];
        [voiceBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        [voiceBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];
        [voiceBtn  setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
        [self addSubview:voiceBtn];
        
        [voiceBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [voiceBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4];
        

        
        [self addSubview:self.mInputTextView];
       
        [self.mInputTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:voiceBtn withOffset:4];
        [self.mInputTextView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:voiceBtn withOffset:0];
        [self.mInputTextView  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        
        
        UIButton *faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        faceBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [faceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        faceBtn.backgroundColor = [UIColor clearColor];
        [faceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
        [faceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
        [faceBtn  setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
        [self addSubview:faceBtn];
        
        [faceBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.mInputTextView withOffset:0];
        [faceBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:voiceBtn];
        
      
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [moreBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        moreBtn.backgroundColor = [UIColor clearColor];
        [moreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
        [moreBtn  setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
        [self addSubview:moreBtn];
        
        [moreBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:voiceBtn];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [moreBtn  autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:faceBtn withOffset:0];
        
    }
    return self;
}

-(void)voiceBtnClick:(UIButton*)sender
{
    if (sender.selected)
    {
        [self.mInputTextView becomeFirstResponder];
    }else
    {
        [self.mInputTextView resignFirstResponder];
    }
    
    sender.selected = !sender.selected;
}


#pragma mark - Getter Method

-(UITextView *)mInputTextView
{
    if (_mInputTextView) {
        return _mInputTextView;
    }
    
    _mInputTextView = [[UITextView alloc]initForAutoLayout];

    _mInputTextView.layer.cornerRadius = 4;
    _mInputTextView.layer.masksToBounds = YES;
    _mInputTextView.layer.borderWidth = 1;
    _mInputTextView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    
    _mInputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f);
    _mInputTextView.contentInset = UIEdgeInsetsZero;
    _mInputTextView.scrollEnabled = YES;
    _mInputTextView.scrollsToTop = NO;
    _mInputTextView.userInteractionEnabled = YES;
    _mInputTextView.font = [UIFont systemFontOfSize:12];
    _mInputTextView.textColor = [UIColor blackColor];
    _mInputTextView.backgroundColor = [UIColor whiteColor];
    _mInputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    _mInputTextView.keyboardType = UIKeyboardTypeDefault;
    _mInputTextView.returnKeyType = UIReturnKeyDefault;
    _mInputTextView.textAlignment = NSTextAlignmentLeft;
    
    return _mInputTextView;
}


@end
