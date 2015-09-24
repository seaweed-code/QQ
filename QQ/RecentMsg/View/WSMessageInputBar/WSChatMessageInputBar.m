//
//  WSChatMessageInputBar.m
//  QQ
//
//  Created by weida on 15/9/23.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatMessageInputBar.h"
#import "PureLayout.h"
#import "UIResponder+Router.h"
#import "WSChatModel.h"

//背景颜色
#define kBkColor               ([UIColor colorWithRed:0.922 green:0.925 blue:0.929 alpha:1])

//自身默认高度
#define kDefaultHeight          (40)

//输入框最大高度
#define kMaxHeightInputTextView   (88)
//按钮大小
#define kSizeBtn                 (CGSizeMake(34, 34))

@interface WSChatMessageInputBar ()<UITextViewDelegate>
{
    
    /**
     *  @brief  自己高度,每次重新设置了必须刷新自己的 固有内容尺寸
     */
    CGFloat mHeight;
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
        
        mHeight = kDefaultHeight;
        
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
        [voiceBtn autoSetDimensionsToSize:kSizeBtn];
        

        
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
        [faceBtn  autoSetDimensionsToSize:kSizeBtn];
        
      
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
        [moreBtn autoSetDimensionsToSize:kSizeBtn];
        [moreBtn  autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:faceBtn withOffset:0];
        
    }
    return self;
}


-(CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, mHeight);
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

    _mInputTextView.delegate = self;
    _mInputTextView.layer.cornerRadius = 4;
    _mInputTextView.layer.masksToBounds = YES;
    _mInputTextView.layer.borderWidth = 1;
    _mInputTextView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    _mInputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f);
    _mInputTextView.contentInset = UIEdgeInsetsZero;
    _mInputTextView.scrollEnabled = NO;
    _mInputTextView.scrollsToTop = NO;
    _mInputTextView.userInteractionEnabled = YES;
    _mInputTextView.font = [UIFont systemFontOfSize:12];
    _mInputTextView.textColor = [UIColor blackColor];
    _mInputTextView.backgroundColor = [UIColor whiteColor];
    _mInputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    _mInputTextView.keyboardType = UIKeyboardTypeDefault;
    _mInputTextView.returnKeyType = UIReturnKeySend;
    _mInputTextView.textAlignment = NSTextAlignmentLeft;
    
    return _mInputTextView;
}

#pragma mark -TextView Delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {//点击了发送按钮
       
        if (![textView.text isEqualToString:@""])
        {//输入框当前有数据才需要发送
           
            [self routerEventWithType:EventChatCellTypeSendMsgEvent userInfo:@{@"type":@(WSChatCellType_Text),@"text":textView.text}];
            
            textView.text = @"";//清空输入框
            [self textViewDidChange:textView];
        }
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    //计算输入框最小高度
    CGSize size =  [textView sizeThatFits:CGSizeMake(textView.contentSize.width, 0)];
    
    CGFloat contentHeight;

    //输入框的高度不能超过最大高度
    if (size.height > kMaxHeightInputTextView)
    {
        contentHeight = kMaxHeightInputTextView;
        textView.scrollEnabled = YES;
    }else
    {
        contentHeight = size.height;
        textView.scrollEnabled = NO;
    }
    
    
    if (mHeight != contentHeight+11)
    {//如果当前高度需要调整，就调整，避免多做无用功
        mHeight = contentHeight + 11;//重新设置自己的高度
        [self invalidateIntrinsicContentSize];
    }
}


@end
