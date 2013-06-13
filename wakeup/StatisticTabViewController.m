//
//  StatisticTabViewController.m
//  wakeup
//
//  Created by din1030 on 13/6/11.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "StatisticTabViewController.h"
#import "RecordViewController.h"

@interface StatisticTabViewController ()

@end

@implementation StatisticTabViewController

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
    self.delegate = self;
    UITabBar *tabBar = self.tabBarController.tabBar;
    _cur_tab = tabBar.selectedItem.tag;
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"selected %d",tabBarController.selectedIndex);
//    if ([tabBarController selectedIndex] == 0)
//    {
//        RecordViewController *vc = (RecordViewController*)viewController;
//        vc.record.tab_index = tabBarController.selectedIndex;
//        [vc viewDidLoad];

//        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[tabBarController viewControllers]];
//        
//        RecordViewController *nvc = [[RecordViewController alloc] init];
//        [[nvc record] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
//        [nvc setCur_tab:tabBarController.selectedIndex];
//        [arr replaceObjectAtIndex:1 withObject:nvc];
//        
//        [nvc release];
//        [tabBarController setViewControllers:arr];
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
