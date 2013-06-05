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
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    flag=NO;
    base=0;
}

//设置collectionViewContentsize
- (CGSize) collectionViewContentSize{
    return self.collectionView.frame.size;
}

//设置UICollectionViewLayoutAttributes

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //算row&column
    if (indexPath.item%5==0)
    {
        row = indexPath.item/5*2;
        column=0;
    }
    else
    {
        if (indexPath.item%5==3)
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
    if(row%2==0)
        attributes.center = CGPointMake( (screen_width-ITEM_SIZE*3)/2 + ITEM_SIZE/2 + ITEM_SIZE*column + (column-1)*20,ITEM_SIZE/2 + ITEM_SIZE*row + (row+1)*20);
    else
        attributes.center = CGPointMake( (screen_width-ITEM_SIZE*2)/2 + ITEM_SIZE/2 + ITEM_SIZE*column + (column-1)*20,ITEM_SIZE/2 + ITEM_SIZE*row + (row+1)*20);
    return attributes;
}

//用来在一开始给出一套UICollectionViewLayoutAttributes
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{ NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        //这里利用了-layoutAttributesForItemAtIndexPath:来获取attributes
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end
