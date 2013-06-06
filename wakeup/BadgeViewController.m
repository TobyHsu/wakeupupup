//
//  BadgeViewController.m
//  wakeup
//
//  Created by din1030 on 13/6/3.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "BadgeViewController.h"
#import "Parse/Parse.h"
#import "BadgeCollectionCell.h"

@interface BadgeViewController ()

@end

@implementation BadgeViewController

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
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBackgroundImage:[UIImage imageNamed:@"badge_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    PFQuery *person_badge = [PFQuery queryWithClassName:@"PERSON_BADGE"];
    self.pobj_ar = [person_badge findObjects];
    
    PFQuery *animal_badge = [PFQuery queryWithClassName:@"ANIMAL_BADGE"];
    self.aobj_ar = [animal_badge findObjects];

    self.obj_ar = [[NSMutableArray alloc]initWithObjects:self.pobj_ar,self.aobj_ar, nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBackgroundImage:[UIImage imageNamed:@"badge_bar.png"] forBarMetrics:UIBarMetricsDefault];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.obj_ar count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.obj_ar objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"badge_cell";
    BadgeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSArray *rnd_img = [[NSArray alloc] initWithObjects:@"badge_tw.png",@"badge_tw_n.png",@"badge_jp.png",@"badge_jp_n.png",@"Squirrel.png",@"Squirrel_n.png", nil];
    int r = arc4random_uniform(6);
    cell.badge_thumbnail.image = [UIImage imageNamed:[rnd_img objectAtIndex:r]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
@end
