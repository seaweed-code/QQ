//
//  AppDelegate.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "AppDelegate.h"
#import "MessageViewController.h"
#import "TelphoneViewController.h"
#import "DynamicViewController.h"


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
    
    MessageViewController *message = [[MessageViewController alloc]init];
    
    [message.tabBarItem setTitle:@"消息"];
    
    TelphoneViewController *tel = [[TelphoneViewController alloc]init];
    
    [tel.tabBarItem setTitle:@"联系人"];

    DynamicViewController *dynamic = [[DynamicViewController alloc]init];
    
    [dynamic.tabBarItem setTitle:@"动态"];
    
    [_mainTabBar setViewControllers:@[message,tel,dynamic]];
    
    return _mainTabBar;
}


@end
