//
//  AlarmViewController.m
//  Alarm
//
//  Created by François Beausoleil on 10-11-23.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import "AlarmViewController.h"
#import "SleepPeriod.h"

@implementation AlarmViewController

@synthesize currentPeriod, bedtimeDisplay, hoursOfSleepDisplay;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];

  self.hoursOfSleepDisplay.hidden = YES;
  self.bedtimeDisplay.hidden = YES;
  self.periods = [NSMutableArray array];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
  [formatter release];
  formatter = nil;
  
  self.currentPeriod = nil;
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

  [self ensureFormatter];
  self.hoursOfSleepDisplay.text = [self.currentPeriod durationInHoursMinutes];
  self.hoursOfSleepDisplay.hidden = NO;
}

@end
