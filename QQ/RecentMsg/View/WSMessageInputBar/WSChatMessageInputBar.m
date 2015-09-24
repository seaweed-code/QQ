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
#import "WSChatMessageMoreView.h"

//背景颜色
#define kBkColor               ([UIColor colorWithRed:0.922 green:0.925 blue:0.929 alpha:1])

//输入框最小高度
#define kMinHeightTextView          (34)

//输入框最大高度
#define kMaxHeightTextView   (88)

//默认输入框和父控件底部间隔
#define kDefaultBottomTextView_SupView  (6)

//按钮大小
#define kSizeBtn                 (CGSizeMake(34, 34))

@interface WSChatMessageInputBar ()<UITextViewDelegate>
{
    /**
     *  @brief  TextView和父控件底部约束，会被动态增加、删除
     */
    NSLayoutConstraint *mBottomConstraintTextView;
    
    
    
    /**
     *  @brief  TextView的高度
     */
    CGFloat mHeightTextView;
    
    
    /**
     *  @brief  更多视图
     */
    WSChatMessageMoreView *mMoreView;
}


/**
 *  @brief  输入TextView
 */
@property(nonatomic,strong)UITextView *mInputTextView;

/**
 *  @brief  录制语音按钮
 */
@property(nonatomic,strong)UIButton   *mVoiceBtn;

/**
 *  @brief  表情按钮
 */
@property(nonatomic,strong)UIButton   *mFaceBtn;

/**
 *  @brief  更多按钮
 */
@property(nonatomic,strong)UIButton   *mMoreBtn;

@end

@implementation WSChatMessageInputBar



-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = kBkColor;
        mHeightTextView = kMinHeightTextView; //默认设置输入框最小高度
        
        /**
         *  @brief  增加录音按钮
         */
        [self addSubview:self.mVoiceBtn];
        [self.mVoiceBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [self.mVoiceBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4];
        

        /**
         *  @brief  增加输入框
         */
        [self addSubview:self.mInputTextView];
        [self.mInputTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.mVoiceBtn withOffset:4];
        [self.mInputTextView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.mVoiceBtn withOffset:0];
        mBottomConstraintTextView = [self.mInputTextView  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kDefaultBottomTextView_SupView];
        
        /**
         *  @brief  增加表情按钮
         */
        [self addSubview:self.mFaceBtn];
        [self.mFaceBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.mInputTextView withOffset:0];
        [self.mFaceBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.mVoiceBtn];
       
        /**
         *  @brief  增加更多按钮
         */
        [self addSubview:self.mMoreBtn];
        [_mMoreBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.mVoiceBtn];
        [_mMoreBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [_mMoreBtn  autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.mFaceBtn withOffset:0];
        
    }
    return self;
}

/**
 *  @brief  返回自己的固有内容尺寸，刷新固有内容尺寸系统将会重新调用此方法
 *
 *  @return 宽度不设置固有内容尺寸，只设置高度
 */
-(CGSize)intrinsicContentSize
{
    CGFloat height = mHeightTextView+kDefaultBottomTextView_SupView +4;
    
    if (mMoreView)
    {//如果更多视图当前正在显示，需要加上更多视图的高度
        height += [mMoreView intrinsicContentSize].height;
    
    }
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height);
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


-(void)moreBtnClick:(UIButton*)sender
{
    if (sender.selected)
    {//隐藏更多界面，显示键盘输入
        
        [mMoreView removeFromSuperview];
        mMoreView = nil;
    
        mBottomConstraintTextView.constant = -kDefaultBottomTextView_SupView;
    
        [self.mInputTextView becomeFirstResponder];
    }else
    {//隐藏键盘，显示更多界面
        
        mMoreView = [[WSChatMessageMoreView alloc]init];
        mMoreView.translatesAutoresizingMaskIntoConstraints = NO;
    
        [self addSubview:mMoreView];
    
        
        [mMoreView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [mMoreView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [mMoreView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mInputTextView withOffset:6];
        
        mBottomConstraintTextView.constant = -(kDefaultBottomTextView_SupView+[mMoreView intrinsicContentSize].height);
        
        [self.mInputTextView resignFirstResponder];
    }
    
    [self invalidateIntrinsicContentSize];
    
    sender.selected = !sender.selected;

    
    
    
}


#pragma mark - Getter Method

-(UIButton *)mMoreBtn
{
    if (_mMoreBtn) {
        return _mMoreBtn;
    }
    
    _mMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mMoreBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_mMoreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mMoreBtn.backgroundColor = [UIColor clearColor];
    [_mMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [_mMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
    [_mMoreBtn  setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
    [_mMoreBtn autoSetDimensionsToSize:kSizeBtn];
    
    
    return _mMoreBtn;
}

-(UIButton *)mVoiceBtn
{
    if (_mVoiceBtn) {
        return _mVoiceBtn;
    }
    
    _mVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mVoiceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_mVoiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mVoiceBtn.backgroundColor = [UIColor clearColor];
    [_mVoiceBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
    [_mVoiceBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];
    [_mVoiceBtn  setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
    [_mVoiceBtn autoSetDimensionsToSize:kSizeBtn];
    
    
    return _mVoiceBtn;
}

-(UIButton *)mFaceBtn
{
    if (_mFaceBtn) {
        return _mFaceBtn;
    }
    
    _mFaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mFaceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_mFaceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mFaceBtn.backgroundColor = [UIColor clearColor];
    [_mFaceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [_mFaceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
    [_mFaceBtn  setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
    [_mFaceBtn autoSetDimensionsToSize:kSizeBtn];
    
    
    return _mFaceBtn;
}

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

//判断用户是否点击了键盘发送按钮
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

//根据输入文字多少，自动调整输入框的高度
-(void)textViewDidChange:(UITextView *)textView
{
    //计算输入框最小高度
    CGSize size =  [textView sizeThatFits:CGSizeMake(textView.contentSize.width, 0)];
    
    CGFloat contentHeight;

    //输入框的高度不能超过最大高度
    if (size.height > kMaxHeightTextView)
    {
        contentHeight = kMaxHeightTextView;
        textView.scrollEnabled = YES;
    }else
    {
        contentHeight = size.height;
        textView.scrollEnabled = NO;
    }
    
    
    if (mHeightTextView != contentHeight)
    {//如果当前高度需要调整，就调整，避免多做无用功
        mHeightTextView = contentHeight ;//重新设置自己的高度
        [self invalidateIntrinsicContentSize];
    }
}


@end
