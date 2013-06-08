//
//  BadgeHeaderView.m
//  wakeup
//
//  Created by din1030 on 13/6/8.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "BadgeHeaderView.h"

@implementation BadgeHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300,80)];
        self.title.font = [UIFont systemFontOfSize:20];
        self.title.textColor = [UIColor whiteColor];
        self.title.backgroundColor = [UIColor redColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.title setCenter:CGPointMake( frame.size.width/2,frame.size.height/2)];
        //self.title.text = @"TEST!!!";
        [self addSubview:self.title];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
