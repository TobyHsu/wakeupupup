//
//  RecordScrollView.m
//  wakeup
//
//  Created by din1030 on 13/5/27.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "RecordScrollView.h"
#import "JSONKit.h"

@implementation RecordScrollView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setBackgroundColor:[UIColor whiteColor]];
		NSLog(@"123");
		self.lineChartView = [[PCLineChartView alloc] initWithFrame:CGRectMake(10,10,31*30+80,[self bounds].size.height-20)];
		[self.lineChartView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		self.lineChartView.minValue = 0;
		self.lineChartView.maxValue = 12;
        self.contentSize = CGSizeMake([_lineChartView.xLabels count] * 50 + 100, self.frame.size.height);
        self.lineChartView.scrollEnabled = YES;
		[self addSubview:self.lineChartView];
		
        [self setContentSize:CGSizeMake(self.lineChartView.frame.size.width, self.lineChartView.frame.size.height)];
        [self setScrollEnabled:YES];
        
        #warning Make fake data replacing JSON
        
		NSString *sampleFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"sample_linechart_data.json"];
		NSString *jsonString = [NSString stringWithContentsOfFile:sampleFile encoding:NSUTF8StringEncoding error:nil];
		
        NSDictionary *sampleInfo = [jsonString objectFromJSONString];
        
        NSMutableArray *components = [NSMutableArray array];
		for (int i=0; i<[[sampleInfo objectForKey:@"data"] count]; i++)
		{
			NSDictionary *point = [[sampleInfo objectForKey:@"data"] objectAtIndex:i];
			PCLineChartViewComponent *component = [[PCLineChartViewComponent alloc] init];
			[component setTitle:[point objectForKey:@"title"]];
			[component setPoints:[point objectForKey:@"data"]];
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
		[_lineChartView setXLabels:[sampleInfo objectForKey:@"x_labels"]];
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
