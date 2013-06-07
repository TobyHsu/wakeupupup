//
//  CustomViewLayout.m
//  test
//
//  Created by Toby Hsu on 13/6/2.
//  Copyright (c) 2013年 Toby Hsu. All rights reserved.
//

#import "CustomViewLayout.h"

@implementation CustomViewLayout

#define ITEM_SIZE 80

-(void)prepareLayout
{
    [super prepareLayout];
    //CGSize size = self.collectionView.frame.size;
    //_cellCount = [[self collectionView] numberOfItemsInSection:0];
    
    flag=NO;
    base=0;
}





//设置collectionViewContentsize
- (CGSize) collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width,([self.collectionView numberOfItemsInSection:0]+[self.collectionView numberOfItemsInSection:1])/ 5 * 2 * (ITEM_SIZE+40));
}

//设置UICollectionViewLayoutAttributes

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section==0) {
        NSLog(@"s,i = %d,%d",indexPath.section,indexPath.item);
        //算row&column
        if (indexPath.item%5==0)
        {
            row = indexPath.item/5*2;
            column=0;
        }
        else
        {
            if (indexPath.item%5==2)
            {
                column=0;
                row = (indexPath.item-indexPath.item/5)/2;
            }
            else
                column++;
        }
        
        int screen_width = self.collectionView.bounds.size.width;
        attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        // 判斷column奇偶數做置中
        if(row%2==1)
            attributes.center = CGPointMake( (screen_width-ITEM_SIZE*3)/2 + ITEM_SIZE/2 + ITEM_SIZE*column + (column-1)*20,ITEM_SIZE/2 + ITEM_SIZE*row + (row+1)*20);
        else
            attributes.center = CGPointMake( (screen_width-ITEM_SIZE*2)/2 + ITEM_SIZE/2 + ITEM_SIZE*column + (column-1)*20,ITEM_SIZE/2 + ITEM_SIZE*row + (row+1)*20);
    }
    else if(indexPath.section==1){
        NSLog(@"s,i = %d,%d",indexPath.section,indexPath.item);
        //算row&column
        if (indexPath.item%5==0)
        {
            row = indexPath.item/5*2;
            column=0;
        }
        else
        {
            if (indexPath.item%5==2)
            {
                column=0;
                row = (indexPath.item-indexPath.item/5)/2;
            }
            else
                column++;
        }
        
        int screen_width = self.collectionView.bounds.size.width;
        attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        // 判斷column奇偶數做置中
        if(row%2==1)
            attributes.center = CGPointMake( (screen_width-ITEM_SIZE*3)/2 + ITEM_SIZE/2 + ITEM_SIZE*column + (column-1)*20,ITEM_SIZE/2 + ITEM_SIZE*row + (row+1)*20+900);
        else
            attributes.center = CGPointMake( (screen_width-ITEM_SIZE*2)/2 + ITEM_SIZE/2 + ITEM_SIZE*column + (column-1)*20,ITEM_SIZE/2 + ITEM_SIZE*row + (row+1)*20+900);
        
        
    }
    return attributes;
}

//用来在一开始给出一套UICollectionViewLayoutAttributes
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSUInteger k =0 ; k < self.collectionView.numberOfSections; k++) {
        for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:k]; i++) {
            //这里利用了-layoutAttributesForItemAtIndexPath:来获取attributes
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:k];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
            NSLog(@"%d,%d",k,i);
        }
    }
    
    return attributes;
}

@end
