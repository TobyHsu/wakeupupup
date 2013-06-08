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
#import "FMDatabase.h"
#import "DataBase.h"

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
    PFQuery *qq = [PFQuery queryWithClassName:@"MISSION"];
    self.obj_ar = [qq findObjects];
    NSLog(@"%d,%@",[self.obj_ar count],[[self.obj_ar objectAtIndex:0] objectForKey:@"name"]);

    // sqlite get mission ids
    //FMResultSet *rs = nil;
    //rs = [DataBase executeQuery:@"SELECT id FROM MISSION"];

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
    return [self.obj_ar count];
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
    NSUInteger ar_index = [indexPath row];
    
    NSString *name = [[self.obj_ar objectAtIndex:ar_index] objectForKey:@"name"];
    //NSString *description = [obj_ar[row] objectForKey:@"description"];
    cell.mission_name.text = name;
    NSLog(@"%@",name);
    
    cell.cell_id = [[self.obj_ar objectAtIndex:ar_index] objectId];
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

@end
