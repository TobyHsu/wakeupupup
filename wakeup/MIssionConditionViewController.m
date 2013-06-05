//
//  MIssionConditionViewController.m
//  wakeup
//
//  Created by din1030 on 13/5/28.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "MIssionConditionViewController.h"

@interface MIssionConditionViewController ()

@end

@implementation MIssionConditionViewController

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
    NSLog(@"%@",self.m_id);
    
    PFQuery *qq = [PFQuery queryWithClassName:@"MISSION"];
    PFObject *obj = [qq getObjectWithId:self.m_id];
    
    NSString *name = [obj objectForKey:@"name"];
    NSString *description = [obj objectForKey:@"description"];
    NSLog(@"name:%@",name);
    NSLog(@"description:%@",description);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
