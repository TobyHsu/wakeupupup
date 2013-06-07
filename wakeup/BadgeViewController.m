//
//  BadgeViewController.m
//  wakeup
//
//  Created by din1030 on 13/6/3.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "BadgeViewController.h"
#import "BadgeCollectionCell.h"
#import "BadgeConditionViewController.h"

#import "Parse/Parse.h"
#import "FMDatabase.h"
#import "DataBase.h"

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
    
    // sqlite get badge ids
    _person_id = [[NSMutableArray alloc] initWithObjects: nil];
    _animal_id = [[NSMutableArray alloc] initWithObjects: nil];
    
    FMResultSet *qq = [DataBase executeQuery:@"SELECT COUNT(*) FROM ANIMAL_BADGE"];
    if ([qq next]) {
        NSLog(@"%d",[qq intForColumnIndex:0]);  // 數量有問題！！！！！幹！！！！
    }
    
    // sqlite 撈兩種 badge id
    FMResultSet *rs1,*rs2 = nil;
    rs1 = [DataBase executeQuery:@"SELECT id FROM PERSON_BADGE"];
    while ([rs1 next])
    {
        NSString *p_id = [rs1 stringForColumn:@"id"];
        [_person_id addObject:p_id];

    }
    rs2 = [DataBase executeQuery:@"SELECT id FROM ANIMAL_BADGE"];
    while ([rs2 next])
    {
        NSString *a_id = [rs2 stringForColumn:@"id"];
        [_animal_id addObject:a_id];
        
    }
    [rs1 close];
    [rs2 close];
    for (int i = 0; i < [_animal_id count];i++ ) {
        NSLog(@"%d:%@",i,[_animal_id objectAtIndex:i]);
    }
    
    self.obj_ar = [[NSMutableArray alloc]initWithObjects:_person_id,_animal_id, nil];

    
//    PFQuery *person_badge = [PFQuery queryWithClassName:@"PERSON_BADGE"];
//    self.pobj_ar = [person_badge findObjects];
//    
//    PFQuery *animal_badge = [PFQuery queryWithClassName:@"ANIMAL_BADGE"];
//    self.aobj_ar = [animal_badge findObjects];

    //self.obj_ar = [[NSMutableArray alloc]initWithObjects:self.pobj_ar,self.aobj_ar, nil];
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
    
    
    NSUInteger section = [indexPath section];
    NSUInteger index = [indexPath row];
    //cell.cell_id = [[self.obj_ar[0] objectAtIndex:index] objectId];
    if (section==0) {
        cell.cell_id = [_person_id objectAtIndex:index];
        cell.cell_type = @"person";
        NSLog(@"%@ at sec 0 ",cell.cell_id);
    }
    else if (section==1) {
        cell.cell_id = [_animal_id objectAtIndex:index];
        cell.cell_type = @"animal";
        NSLog(@"%@ at sec 1 ",cell.cell_id);
    }
    //NSLog(@"%@",cell.cell_id);
    return cell;
}


//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(50, 20, 50, 20);
//}

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
            [conditionPage setValue:cell1.cell_type forKey:@"b_type"];
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
