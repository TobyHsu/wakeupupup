//
//  RecordViewController.m
//  wakeup
//
//  Created by din1030 on 13/5/27.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "RecordViewController123.h"

@interface RecordViewController123 ()

@end

@implementation RecordViewController123

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
    [self.record init];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_record release];
    [super dealloc];
}


@end
