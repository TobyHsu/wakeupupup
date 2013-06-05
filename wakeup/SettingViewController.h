//
//  SettingViewController.h
//  wakeup
//
//  Created by din1030 on 13/5/29.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SettingViewController : UITableViewController
@property (retain, nonatomic) IBOutlet UILabel *timeZone;
@property (strong, nonatomic) IBOutlet UIButton *fbButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@end
