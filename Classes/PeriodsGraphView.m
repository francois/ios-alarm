//
//  PeriodsGraphView.m
//  Alarm
//
//  Created by François Beausoleil on 10-11-25.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import "PeriodsGraphView.h"
#import "SleepPeriod.h"

@implementation PeriodsGraphView

@synthesize periods;

/*
-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}
*/

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  if (!self.periods) return;
  if ([self.periods count] == 0) return;

  UIColor *black = [UIColor blackColor];
  UIColor *white = [UIColor whiteColor];
  UIColor *blue  = [UIColor blueColor];
  UIColor *red   = [UIColor redColor];

  // Bars are hours of sleep
  // Lines are bedtimes
  // Never use more than 80% of the view's height to draw - this way there's always room for improvement
  const CGFloat maxHeight = self.bounds.size.height * 0.8;

  // Start drawing at this many pixels from the edges of the view
  const NSUInteger frameMargin = 4;

  // Add this between days
  const NSUInteger dayMargin = 4;

  const CGFloat barWidth = (self.bounds.size.width / [self.periods count]) - dayMargin - frameMargin;
  CGFloat left = frameMargin;

  NSArray *durations = [self.periods valueForKey:@"durationInSeconds"];

  __block NSTimeInterval maxDuration = 0;
  [durations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj doubleValue] > maxDuration) maxDuration = [obj doubleValue];
  }];

  UIBezierPath *path = [UIBezierPath bezierPath];
  BOOL first = YES;

  NSCalendar *calendar = [NSCalendar currentCalendar];
  for ( SleepPeriod *period in self.periods ) {
    CGFloat barHeight = maxHeight * period.durationInSeconds / maxDuration;
    CGRect bar = CGRectMake(left, self.bounds.size.height - barHeight, barWidth, barHeight);

    [black set];
    UIRectFill(bar);

    // 6 PM becomes midnight, and I'll take whatever hour/minute value I get and plot that on screen
    // Bottom of the view thus becomes 6 PM, and top of view becomes 5:59 PM next day
    NSDateComponents *components = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[NSDate dateWithTimeInterval:-18*60*60 sinceDate:period.bedtime]];
    NSInteger minutesFromMidnight = [components hour] * 60 + [components minute];
    CGFloat minutesPer24Hours = 24 * 60;
    CGFloat bedtimeTop = maxHeight - (maxHeight * (minutesFromMidnight / minutesPer24Hours));
    
    if (first) {
      [path moveToPoint:CGPointMake(left + (barWidth / 2.0) + (dayMargin / 2.0), bedtimeTop)];
      first = false;
    } else {
      [path addLineToPoint:CGPointMake(left + (barWidth / 2.0) + (dayMargin / 2.0), bedtimeTop)];
    }

    NSLog(@"(%g, %g)", left + (barWidth / 2.0) + (dayMargin / 2.0), bedtimeTop);
    left += barWidth + dayMargin;
  }

  [red set];
  path.lineWidth = 4;
  [path stroke];
  
  UIBezierPath *path1 = [UIBezierPath bezierPath];
  [path1 moveToPoint:CGPointMake(0, maxHeight - (maxHeight / 2.0))];
  [path1 addLineToPoint:CGPointMake(self.bounds.size.width, maxHeight - (maxHeight / 2.0))];
  [white set];
  [path1 stroke];
}

- (void)dealloc {
    [super dealloc];
}

-(IBAction)changeNumberOfDaysToDisplay:(id)sender {
  NSLog(@"sender:%@", sender);
}

@end
