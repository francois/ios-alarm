//
//  AlarmViewController.m
//  Alarm
//
//  Created by François Beausoleil on 10-11-23.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import "AlarmViewController.h"
#import "SleepPeriod.h"
#import "PeriodsGraphView.h"

@implementation AlarmViewController

@synthesize currentPeriod, bedtimeDisplay, hoursOfSleepDisplay, periods, graphView;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)demandGraphRedraw {
  NSLog(@"Controller -- periods.count: %d", [self.periods count]);
  NSArray *arr = [self.periods sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"bedtime" ascending:YES]]];
  NSLog(@"arr: %@", arr);
  self.graphView.periods = arr;

  [self.graphView setNeedsDisplay]; 
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];

  self.hoursOfSleepDisplay.hidden = YES;
  self.bedtimeDisplay.hidden = YES;
//  self.periods = [NSSet set];
  NSMutableArray *arr = [NSMutableArray array];
  SleepPeriod *period;
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *comp = [[NSDateComponents alloc] init];
  [comp setCalendar:calendar];
  [comp setTimeZone:[NSTimeZone defaultTimeZone]];
  
  /* Bedtime: 21:27, wakeup: 6:19 */
  period = [[[SleepPeriod alloc] init] autorelease];
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:20];
  [comp setHour:21];
  [comp setMinute:27];
  period.bedtime = [calendar dateFromComponents:comp];
  
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:21];
  [comp setHour:6];
  [comp setMinute:19];
  period.wakeuptime = [calendar dateFromComponents:comp];
  [arr addObject:period];
  
  /* Bedtime: 22:43, wakeup: 6:10 */
  period = [[[SleepPeriod alloc] init] autorelease];
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:21];
  [comp setHour:22];
  [comp setMinute:43];
  period.bedtime = [calendar dateFromComponents:comp];
  
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:22];
  [comp setHour:6];
  [comp setMinute:10];
  period.wakeuptime = [calendar dateFromComponents:comp];
  [arr addObject:period];
  
  /* Bedtime: 21:14, wakeup: 9:53 */
  period = [[[SleepPeriod alloc] init] autorelease];
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:22];
  [comp setHour:21];
  [comp setMinute:14];
  period.bedtime = [calendar dateFromComponents:comp];
  
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:23];
  [comp setHour:9];
  [comp setMinute:53];
  period.wakeuptime = [calendar dateFromComponents:comp];
  [arr addObject:period];
  
  /* Bedtime: 21:37, wakeup: 8:15 */
  period = [[[SleepPeriod alloc] init] autorelease];
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:23];
  [comp setHour:21];
  [comp setMinute:37];
  period.bedtime = [calendar dateFromComponents:comp];
  
  [comp setYear:2010];
  [comp setMonth:11];
  [comp setDay:24];
  [comp setHour:8];
  [comp setMinute:15];
  period.wakeuptime = [calendar dateFromComponents:comp];
  [arr addObject:period];
  
  self.periods = [NSSet setWithArray:arr];
  [self demandGraphRedraw];
  [comp release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
  [formatter release];
  formatter = nil;
}

- (void)viewDidUnload {
  self.currentPeriod = nil;
  self.bedtimeDisplay = nil;
  self.hoursOfSleepDisplay = nil;

  [super viewDidUnload];
}

#
#pragma mark Localization
#

-(void)ensureFormatter {
  if (formatter) return;

  formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:NSDateFormatterNoStyle];
  [formatter setTimeStyle:NSDateFormatterShortStyle];
}

#
#pragma mark Sleep Cycle
#

-(IBAction)goToBed:(id)sender {
  self.currentPeriod = [SleepPeriod initWithBedtimeToNow];
  [self ensureFormatter];

  self.bedtimeDisplay.text = [formatter stringFromDate:self.currentPeriod.bedtime];
  self.bedtimeDisplay.hidden = NO;
}

-(IBAction)wakeUp:(id)sender {
  [self.currentPeriod wakeup];

  NSMutableSet *newPeriods = [[self.periods mutableCopy] autorelease];
  [newPeriods addObject:self.currentPeriod];
  self.periods = newPeriods;
  [self demandGraphRedraw];

  [self ensureFormatter];
  self.hoursOfSleepDisplay.text = [self.currentPeriod durationInHoursMinutes];
  self.hoursOfSleepDisplay.hidden = NO;
}

@end
