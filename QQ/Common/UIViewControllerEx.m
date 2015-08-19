//
//  UIViewController+UIViewControllerEx.m
//  QQ
//
//  Created by weida on 15/8/19.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "UIViewControllerEx.h"

@interface UIViewController ()<UIGestureRecognizerDelegate>

@end

@implementation UIViewController (UIViewControllerEx)

/**
 *  @brief  设置导航控制器全屏滑动返回
 */
-(void)setPanGesture
{
    if (!self.navigationController)
        return;
    
    if (![self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        return;
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    if (!target)
        return;
    
    SEL select = @selector(handleNavigationTransition:);
    
    if ([target respondsToSelector:select])
    {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:select];
        
        pan.delegate = self;
        
        [self.view addGestureRecognizer:pan];
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return  (self.childViewControllers.count != 1);
}

@end
