//
//  AlarmViewController.m
//  wakeup
//
//  Created by Toby Hsu on 13/6/5.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "AlarmViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BrainHoleViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface AlarmViewController ()

@end

@implementation AlarmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBackgroundImage:[UIImage imageNamed:@"set_alarm_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,21,21);
    [button setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    CGPoint center = self.alarm.center;
    self.set.center = CGPointMake(center.x,center.y+120);
    self.alarm_min.center = CGPointMake(center.x,center.y);
    self.alarm_hr.center = CGPointMake(center.x,center.y);
    self.alarm_alarm.center = CGPointMake(center.x,center.y);
    self.alarm_sec.center = CGPointMake(center.x,center.y-2);
    [self.alarm_min.layer setAnchorPoint:CGPointMake(0.5,0)];
    [self.alarm_hr.layer setAnchorPoint:CGPointMake(0.5,0)];
    [self.alarm_alarm.layer setAnchorPoint:CGPointMake(0.5,0)];
    [self.alarm_sec.layer setAnchorPoint:CGPointMake(0.5,0.1)];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isAlarm = NO;
    timer=[NSTimer scheduledTimerWithTimeInterval:0.03
                                                       target:self
                                                     selector:@selector(countUp)
                                                     userInfo:nil
                                                      repeats:YES];
    self.label_alarm_time.text = [NSString stringWithFormat:@"%02d:%02d",appDelegate.set_hr,appDelegate.set_min];
    
    
    flag=NO;
    NSURL* url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"turn" ofType:@"mp3"]];
    //與音樂檔案做連結
    NSError* error = nil;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // notification後進入遊戲
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(Game:)
                                                     name:@"appDidBecomeActive"
                                                   object:nil];
    
    self.alarm_alarm.transform = CGAffineTransformMakeRotation(DegreesToRadians((appDelegate.set_hr%12*60.0+appDelegate.set_min)*0.5+180));
    self.set.transform= CGAffineTransformMakeRotation(DegreesToRadians((appDelegate.set_hr%12*60.0+appDelegate.set_min)*0.5+180));
    
    center = self.set.center;
    center.x = self.mask.center.x + self.mask.frame.size.width/2 * cos(appDelegate.degree);
    center.y = self.mask.center.y - self.mask.frame.size.height/2 * sin(appDelegate.degree);
    self.set.center = center;
    
}

- (void)countUp {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.alarm_hr.transform = CGAffineTransformMakeRotation(DegreesToRadians((appDelegate.hr*60.0+appDelegate.min)*0.5+180));
    self.alarm_min.transform = CGAffineTransformMakeRotation(DegreesToRadians(appDelegate.min*6.0+180));
    self.alarm_sec.transform = CGAffineTransformMakeRotation(DegreesToRadians(appDelegate.sec*6.0+180));
}

- (void)Game:(NSString *)clock_id
{
    // 切換clock_id對應的遊戲
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isAlarm = NO;
    BrainHoleViewController *brainhole_vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GamePage"];
    [self.navigationController pushViewController:brainhole_vc animated:YES];
}

CGFloat DegreesToRadians(CGFloat degrees)
{
    degrees = (int)degrees%360;
    return degrees * M_PI / 180;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_alarm release];
    [_mask release];
    [_alarm_min release];
    [_alarm_hr release];
    [_alarm_alarm release];
    [_alarm_sec release];
    [_mask release];
    [_label_alarm_time release];
    [_setalarm release];
    [timer invalidate];
    [super dealloc];
}
- (IBAction)alarm_pan:(UIPanGestureRecognizer *)sender {
    if (!flag){
        CGPoint center = self.set.center;
        CGPoint touch = [sender locationInView:self.view];
        CGPoint mask_center = self.mask.center;
        
        double rotateDegree = atan2((touch.x-mask_center.x),(touch.y-mask_center.y)) * 180.0 / M_PI -90;
        self.set.transform = CGAffineTransformMakeRotation(DegreesToRadians(360-rotateDegree-90));
        self.alarm_alarm.transform = CGAffineTransformMakeRotation(DegreesToRadians(360-rotateDegree-90));
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.set_hr = (int)abs(rotateDegree-90)/30;
        if (appDelegate.set_hr==0)
            appDelegate.set_hr=12;
        if (abs(appDelegate.set_min -(int)abs((rotateDegree-90)*2)%60)>1)
        {
            [audioPlayer setNumberOfLoops:0];
            [audioPlayer play];
        }
        appDelegate.set_min = (int)abs((rotateDegree-90)*2)%60;
        self.label_alarm_time.text = [NSString stringWithFormat:@"%02d:%02d",appDelegate.set_hr,appDelegate.set_min];
        center.x = self.mask.center.x + self.mask.frame.size.width/2 * cos(rotateDegree*(M_PI/180));
        center.y = self.mask.center.y - self.mask.frame.size.height/2 * sin(rotateDegree*(M_PI/180));
        appDelegate.degree = rotateDegree*(M_PI/180);
        self.set.center = center;
    }
    
}

- (IBAction)alarmClick:(UIButton *)sender {
    flag = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isAlarm = YES;
    TimerTask = [[UIApplication sharedApplication]
                 beginBackgroundTaskWithExpirationHandler:^{
                     // If you're worried about exceeding 10 minutes, handle it here
                 }];
    NSLog(@"%d:%d",appDelegate.set_hr,appDelegate.set_min);
    // 背景執行Code
    //    [[UIApplication sharedApplication] endBackgroundTask:counterTask];
}
@end
