//
//  AppDelegate.h
//  wakeup
//
//  Created by din1030 on 13/5/8.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AVFoundation/AVAudioPlayer.h>

extern NSString *const FBSessionStateChangedNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void) closeSession;
- (void) Alarm;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL isAlarm;
@property (strong, nonatomic) AVAudioPlayer *bgPlayer;
@property (strong,nonatomic) NSTimer *timer;
@property (nonatomic)int set_hr,set_min;
@property (nonatomic)int hr,min,sec;
@property (nonatomic)float degree;
@property (strong,nonatomic)UILocalNotification *scheduledAlert;

@end
