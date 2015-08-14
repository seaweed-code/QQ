//
//  AppDelegate.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "AppDelegate.h"
#import "WSNavigationController.h"
#import "WSRecentMsgViewController.h"
#import "WSTelphoneViewController.h"
#import "WSDynamicViewController.h"


@interface AppDelegate ()


@property(nonatomic,strong) UITabBarController *mainTabBar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    
    self.window.rootViewController = self.mainTabBar;
    
    [self.window makeKeyAndVisible];
   
    return YES;
}

-(UITabBarController *)mainTabBar
{
    if (_mainTabBar) {
        return _mainTabBar;
    }
    
    _mainTabBar = [[UITabBarController alloc]init];
    
    WSRecentMsgViewController *message = [[WSRecentMsgViewController alloc]init];
    
    WSTelphoneViewController *tel = [[WSTelphoneViewController alloc]init];

    WSDynamicViewController *dynamic = [[WSDynamicViewController alloc]init];
    
    [_mainTabBar setViewControllers:@[[[WSNavigationController alloc]initWithRootViewController:message],[[WSNavigationController alloc]initWithRootViewController:tel],[[WSNavigationController alloc]initWithRootViewController:dynamic]]];
    
    return _mainTabBar;
}


@end
