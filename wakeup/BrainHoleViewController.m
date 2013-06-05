//
//  BrainHoleViewController.m
//  wakeup
//
//  Created by din1030 on 13/5/30.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "BrainHoleViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BrainHoleViewController ()
@end

@implementation BrainHoleViewController

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
	// Do any additional setup after loading the view.
    remain_hole = kHOLES;
    self.hole_img = [NSArray arrayWithObjects:@"brainhole1.png",@"brainhole2.png",@"brainhole3.png",@"brainhole4.png",nil];
    
    [_eye.layer setAnchorPoint: CGPointMake(0.5,0.5)];
    levelup_timer = [NSTimer scheduledTimerWithTimeInterval:8  // 洞升級秒數
                                                     target:self
                                                   selector:@selector(generateHole)
                                                   userInfo:nil
                                                    repeats:YES];
    
    game_timer = [NSTimer scheduledTimerWithTimeInterval:1  // 遊戲秒數
                                                  target:self
                                                selector:@selector(counting)
                                                userInfo:nil
                                                 repeats:YES];
    
    audioArray = [[NSArray alloc] initWithObjects:@"laughing2",@"get up7", nil];
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"back4" ofType:@"mp3"]];
    //與音樂檔案做連結
    NSError* error = nil;
    bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [bgPlayer setNumberOfLoops:-1];
    [bgPlayer play];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_eye release];
    [super dealloc];
}

- (void) counting
{
    sec++;
    NSURL* url = [[NSURL alloc]init];
    //與音樂檔案做連結
    NSError* error = nil;

    if (sec==15)
    {
        NSURL* url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"you are too slow2" ofType:@"mp3"]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [audioPlayer setNumberOfLoops:0];
        [audioPlayer play];
    }
    else
    {
        if (sec%5==0)
        {
            int r = arc4random_uniform(2);
            NSURL* url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:[audioArray objectAtIndex:r] ofType:@"mp3"]];
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
            [audioPlayer setNumberOfLoops:0];
            [audioPlayer play];
        }
    }
}

- (void) generateHole
{
    for (id obj in self.view.subviews)
    {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *oldHole = (UIButton*) obj;
            
            
            switch (oldHole.tag) {  // 判斷下個 level 的圖
                case 1:
                    [oldHole setBackgroundImage:[UIImage imageNamed:@"brainhole2.png"] forState:UIControlStateNormal];
                    oldHole.tag++;
                    NSLog(@"new hole 2");
                    break;
                case 2:
                    [oldHole setBackgroundImage:[UIImage imageNamed:@"brainhole3.png"] forState:UIControlStateNormal];
                    oldHole.tag++;
                    NSLog(@"new hole 3");
                    break;
                case 3:
                    [oldHole setBackgroundImage:[UIImage imageNamed:@"brainhole4.png"] forState:UIControlStateNormal];
                    oldHole.tag++;
                    NSLog(@"new hole 4");
                    break;
                case 0:
                    oldHole.hidden = NO;
                    oldHole.tag++;
                    remain_hole++;
                    break;
            }
            // 接 action ＆ 放回 view
            //[oldHole addTarget:self action:@selector(holeClick:) forControlEvents:UIControlEventTouchUpInside];
            //[self.view addSubview:newHole];
        }
    }
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"i got a hole1" ofType:@"mp3"]];
    //與音樂檔案做連結
    NSError* error = nil;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer setNumberOfLoops:0];
    [audioPlayer play];
    
}

- (IBAction)holeClick:(UIButton*)sender
{
    NSURL* url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"mp3"]];
    //與音樂檔案做連結
    NSError* error = nil;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer play];
    
    UIButton *thisHole = (UIButton*) sender;
    //thisHole.tag--;
    if (thisHole.tag == 1) {
        thisHole.tag--;
        thisHole.hidden = YES;
        remain_hole--;
        if (remain_hole == 0) {
            NSLog(@"SUCCES!!!");
            [levelup_timer invalidate];
            [game_timer invalidate];
            [audioPlayer stop];
            [bgPlayer stop];
            [self showAlert];
        }
    }
    else {
        thisHole.tag--;
        NSLog(@"%d",thisHole.tag);
        [thisHole setBackgroundImage:[UIImage imageNamed:[self.hole_img objectAtIndex:(thisHole.tag-1)]] forState:UIControlStateNormal];
    }
    //[levelup_timer invalidate];
}

-(void) showAlert
{
    [[[[UIAlertView alloc]
       initWithTitle:@"恭喜！"
       message:[NSString stringWithFormat:@"花了%d秒成功填補所有腦洞啦～～",sec]
       delegate:self
       cancelButtonTitle:@"OK"
       otherButtonTitles: nil] autorelease] show];
    
}

// 按了 alert 的 按鈕之後的動作（發佈到fb、轉回首頁。
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //將按鈕的Title當作判斷的依據
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"OK"]) {
        NSLog(@"after click OK button");
        [self performSegueWithIdentifier:@"backHome" sender:self];
    }
    
}

@end
