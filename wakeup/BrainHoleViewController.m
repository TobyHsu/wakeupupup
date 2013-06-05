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
    levelup_timer = [NSTimer scheduledTimerWithTimeInterval:9  // 洞升級秒數
                                           target:self
                                         selector:@selector(generateHole)
                                         userInfo:nil
                                          repeats:YES];
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

}

- (IBAction)holeClick:(UIButton*)sender
{
    UIButton *thisHole = (UIButton*) sender;
    //thisHole.tag--;
    if (thisHole.tag == 1) {
        thisHole.tag--;
        thisHole.hidden = YES;
        remain_hole--;
        if (remain_hole == 0) {
            NSLog(@"SUCCES!!!");
            [levelup_timer invalidate];
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
       message:@"成功填補所有腦洞啦～～"
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
