//
//  TelphoneViewController.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSTelphoneViewController.h"

@interface WSTelphoneViewController ()

@end

@implementation WSTelphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系人";
    self.view.backgroundColor = [UIColor greenColor];
    
    
    [self.tabBarItem setTitle:@"联系人"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
