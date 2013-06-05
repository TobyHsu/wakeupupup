//
//  AlarmViewController.h
//  wakeup
//
//  Created by Toby Hsu on 13/6/5.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController
{
    NSTimer *timer;
    int hr,sec;
    float min;
    int set_hr,set_min;
    bool flag;
    UIBackgroundTaskIdentifier TimerTask;
}
@property (retain, nonatomic) IBOutlet UIImageView *alarm;
@property (retain, nonatomic) IBOutlet UIImageView *set;
@property (retain, nonatomic) IBOutlet UIImageView *alarm_min;
@property (retain, nonatomic) IBOutlet UIImageView *alarm_hr;
@property (retain, nonatomic) IBOutlet UIImageView *alarm_alarm;
@property (retain, nonatomic) IBOutlet UIImageView *alarm_sec;
@property (retain, nonatomic) IBOutlet UIImageView *mask;
@property (retain, nonatomic) IBOutlet UILabel *label_alarm_time;
@property (retain, nonatomic) IBOutlet UIButton *setalarm;

- (IBAction)alarm_pan:(UIPanGestureRecognizer *)sender;
- (IBAction)alarmClick:(UIButton *)sender;
@end
