//
//  DetailViewController.h
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

