//
//  MissionViewController.m
//  wakeup
//
//  Created by din1030 on 13/5/28.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "MissionViewController.h"
#import "MIssionConditionViewController.h"
#import "MissionCollectionCell.h"
#import "DataBase.h"

#import "AppDelegate.h"
#import "BrainHoleViewController.h"
#import "MISSION.h"

@interface MissionViewController ()

@end

@implementation MissionViewController

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
    // 設定 nav bar
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBackgroundImage:[UIImage imageNamed:@"mission_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 設定透明
    //navBar.translucent = YES;
    
    // 開始撈有哪些 mission
    //    PFQuery *qq = [PFQuery queryWithClassName:@"MISSION"];
    //    self.obj_ar = [qq findObjects];
    //    NSLog(@"%d,%@",[self.obj_ar count],[[self.obj_ar objectAtIndex:0] objectForKey:@"name"]);
    
    //    sqlite get mission ids
    _mission = [[NSMutableArray alloc] initWithObjects: nil];
    FMResultSet *rs = nil;
    rs = [DataBase executeQuery:@"SELECT * FROM MISSION"];
    while ([rs next])
    {
        NSString *m_id = [rs stringForColumn:@"id"];
        NSString *name = [rs stringForColumn:@"name"];
        NSString *description = [rs stringForColumn:@"description"];
        NSString *award_type = [rs stringForColumn:@"award_type"];
        NSString *award_var = [rs stringForColumn:@"award_var"];
        NSString *state = [rs stringForColumn:@"state"];
        
        [_mission addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            m_id, @"id",
                            name, @"name",
                            description, @"description",
                            award_type,@"award_type",
                            award_var,@"award_var",
                            state,@"state",
                            nil]];
    }
    [rs close];

    // notification後進入遊戲
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Game:)
                                                 name:@"appDidBecomeActive"
                                               object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBackgroundImage:[UIImage imageNamed:@"mission_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_mission count];
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
//           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//
//    UICollectionReusableView *supplementaryView = nil;
//
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                               withReuseIdentifier:@"mission_cell"
//                                                                      forIndexPath:indexPath];
//        UILabel *label = (UILabel *)[supplementaryView viewWithTag:TagOfLabelInSupplementatyHeader];
//        label.text = [[ALPhoto sharedSource] arrayOfLocations][indexPath.section];
//    }
//    return supplementaryView;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"mission_cell";
    // Get cell
    MissionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                            forIndexPath:indexPath];
    NSUInteger index = [indexPath row];
    NSString *name = [[_mission objectAtIndex:index ] objectForKey:@"name"];
    //NSString *description = [obj_ar[row] objectForKey:@"description"];
    cell.mission_name.text = name;
    NSLog(@"%@",name);

    cell.cell_id = [[_mission objectAtIndex:0 ] objectForKey:@"id"];
    NSLog(@"%@",cell.cell_id);
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    // Get data first
    //    NSString *location = [[ALPhoto sharedSource] arrayOfLocations][indexPath.section];
    //    NSArray *photos = [[ALPhoto sharedSource] arrayWithPhotosInLocation:location];
    //    NSDictionary *photo = photos[indexPath.row];
    //
    //    // Direction
    //    NSString *direction = photo[ALPhotoInfoDirectionKey];
    //    if ([direction isEqualToString:@"L"]) {
    //        return CGSizeMake(88.0f, 66.0f);
    //    } else {
    return CGSizeMake(263.0f, 150.0f);
    //}
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ShowDetail" sender:cell];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        NSLog(@"detail");
        if ([sender isKindOfClass:[MissionCollectionCell class]]) {
            // Get data
            MissionCollectionCell *cell1 = (MissionCollectionCell *)sender;
            
            //将page2设定成Storyboard Segue的目标UIViewController
            MIssionConditionViewController *conditionPage = segue.destinationViewController; // 這樣回前一頁也會送
            
            //将值透过Storyboard Segue带给页面2的string变数
            [conditionPage setValue:cell1.cell_id forKey:@"m_id"];
            //NSLog(@"%@",[cell1 ind);
        }
    }
}

- (void)Game:(NSString *)clock_id
{
    // 切換clock_id對應的遊戲
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isAlarm = NO;
    BrainHoleViewController *brainhole_vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GamePage"];
    [self.navigationController pushViewController:brainhole_vc animated:YES];
}

@end
