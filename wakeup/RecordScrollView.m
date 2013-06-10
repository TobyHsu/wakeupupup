//
//  RecordScrollView.m
//  wakeup
//
//  Created by din1030 on 13/5/27.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "RecordScrollView.h"
#import "JSONKit.h"
#import "FMDatabase.h"
#import "DataBase.h"

@implementation RecordScrollView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self)
	{
        // 取得現有資料，並依資料數量決定 view 大小
        FMResultSet *rs = nil;
        rs = [DataBase executeQuery:@"SELECT duration_time FROM DAILY_RECORD"];
        NSMutableArray *duration_ar = [NSMutableArray array];
        while ([rs next])
        {
            NSUInteger duration = [rs intForColumn:@"duration_time"];
            [duration_ar addObject:[NSString stringWithFormat:@"%d",duration]];
            
        }
        int data_amount = [duration_ar count];
        
        // 設定折線圖 view 大小位置 及 y 軸最大最小值
		self.lineChartView = [[PCLineChartView alloc] initWithFrame:CGRectMake(10,10,data_amount*30+100,[self bounds].size.height-20)];
		[self.lineChartView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		self.lineChartView.minValue = 0;
		self.lineChartView.maxValue = 12;
		[self addSubview:self.lineChartView];
        
        // 設定 scroll veiw 大小
        [self setContentSize:CGSizeMake(self.lineChartView.frame.size.width, self.lineChartView.frame.size.height)];
        [self setScrollEnabled:YES];
        
        // 建立折線圖所需 dictionary 資料
        NSDictionary *dailyInfo = [[NSDictionary alloc] initWithObjectsAndKeys:duration_ar,@"dailyData",@"din1010",@"name",nil];
        NSMutableArray *userInfo_ar = [[NSMutableArray alloc] initWithObjects:dailyInfo, nil];
        
        // 日期 for x labels
        NSMutableArray *date_ar = [NSMutableArray array];
        for (int day = 1; day <= [duration_ar count]; day++)
        {
            [date_ar addObject:[NSString stringWithFormat:@"%d",day]];
        }
        NSDictionary *Info = [[NSDictionary alloc] initWithObjectsAndKeys:userInfo_ar,@"data",date_ar,@"x_labels",nil];
        
        NSMutableArray *components = [NSMutableArray array];
		for (int i = 0; i < [[Info objectForKey:@"data"] count]; i++)
		{
            // 拆 dictionary
            NSDictionary *point = [[Info objectForKey:@"data"] objectAtIndex:i];
			PCLineChartViewComponent *component = [[PCLineChartViewComponent alloc] init];
            [component setTitle:[point objectForKey:@"name"]];
            [component setPoints:[point objectForKey:@"dailyData"]];
            [component setShouldLabelValues:YES];
			if (i==0)
			{
				[component setColour:PCColorYellow];
			}
			else if (i==1)
			{
				[component setColour:PCColorGreen];
			}
			else if (i==2)
			{
				[component setColour:PCColorOrange];
			}
			else if (i==3)
			{
				[component setColour:PCColorRed];
			}
			else if (i==4)
			{
				[component setColour:PCColorBlue];
			}
			
			[components addObject:component];
		}
		[_lineChartView setComponents:components];
		[_lineChartView setXLabels:[Info objectForKey:@"x_labels"]];
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
