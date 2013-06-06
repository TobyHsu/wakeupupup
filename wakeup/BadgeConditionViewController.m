//
//  BadgeConditionViewController.m
//  wakeup
//
//  Created by Toby Hsu on 13/6/6.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "BadgeConditionViewController.h"
#import <Parse/Parse.h>

@interface BadgeConditionViewController ()

@end

@implementation BadgeConditionViewController

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
    PFQuery *qq = [PFQuery queryWithClassName:@"PERSON_BADGE"];
    //    if ([self.b_type isEqualToString:@"person"])
    //        qq = [PFQuery queryWithClassName:@"PERSON_BADGE"];
    //    else
    //        qq = [PFQuery queryWithClassName:@"ANIMAL_BADGE"];
    PFObject *obj = [qq getObjectWithId:self.b_id];
    
    NSString *name = [obj objectForKey:@"name"];
    NSString *description = [obj objectForKey:@"description"];
    NSString *req = [obj objectForKey:@"requirement"];
    NSLog(@"name:%@",name);
    NSLog(@"description:%@",description);
    self.badge_image.image = [UIImage imageNamed:@"badge_tw.png"];
    self.badge_image.frame = CGRectMake(self.badge_image.frame.origin.x,
                                        self.badge_image.frame.origin.y,
                                        200,
                                        225);
    self.badge_description.text = description;
    self.badge_condition.text =  [NSString stringWithFormat:@"必須要在%@點時起床唷！", req];
    // 設定 back button
    UIImage *backButtonIMG = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 21, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonIMG forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UINavigationBar *bar = self.navigationController.navigationBar ;
    bar.topItem.title = @" ";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_badge_image release];
    [_badge_description release];
    [_badge_condition release];
    [super dealloc];
}
@end
