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
#import "BadgeConditionViewController.h"

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
    
    
    NSUInteger index = [indexPath row];
    cell.cell_id = [[self.obj_ar[0] objectAtIndex:index] objectId];
    NSLog(@"%@",cell.cell_id);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ShowDetail" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        NSLog(@"detail");
        if ([sender isKindOfClass:[BadgeCollectionCell class]]) {
            // Get data
            BadgeCollectionCell *cell1 = (BadgeCollectionCell *)sender;
            
            //将page2设定成Storyboard Segue的目标UIViewController
            BadgeConditionViewController *conditionPage = segue.destinationViewController; // 這樣回前一頁也會送
            
            //将值透过Storyboard Segue带给页面2的string变数
            [conditionPage setValue:cell1.cell_id forKey:@"b_id"];
            //NSLog(@"%@",[cell1 ind);
        }
    }
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
