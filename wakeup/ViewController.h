//
//  ViewController.h
//  wakeup
//
//  Created by din1030 on 13/5/8.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *window;
@property (retain, nonatomic) IBOutlet UIButton *alarm;
@property (retain, nonatomic) IBOutlet UIButton *badgetable;
@property (retain, nonatomic) IBOutlet UIButton *theme;
@property (retain, nonatomic) IBOutlet UIButton *calendar;
@property (retain, nonatomic) IBOutlet UIButton *setting;
@property (retain, nonatomic) IBOutlet UIImageView *background;
@property (retain, nonatomic) IBOutlet NSTimer *random_timer;
@property (retain, nonatomic) IBOutlet NSArray *itemlist;

#pragma Theme
@property (retain, nonatomic) IBOutlet NSMutableArray *themelist;
@property (nonatomic) int theme_index;
- (IBAction)theme_OnClick:(UIButton *)sender;
@end
