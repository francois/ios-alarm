//
//  AlarmViewController.m
//  Alarm
//
//  Created by François Beausoleil on 10-11-23.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import "AlarmViewController.h"

@implementation AlarmViewController

@synthesize sleeping, bedTime, wakeupTime, asleepSecondsInLastCycle, bedtimeDisplay, hoursOfSleepDisplay;

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
}

- (void)viewDidUnload {
  self.bedTime = nil;
  self.wakeupTime = nil;
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
  self.bedTime = [NSDate date];
  [self ensureFormatter];
  self.bedtimeDisplay.text = [formatter stringFromDate:self.bedTime];
  self.bedtimeDisplay.hidden = NO;
  self.sleeping = YES;
}

-(IBAction)wakeUp:(id)sender {
  self.wakeupTime = [NSDate date];
  self.asleepSecondsInLastCycle = [self.wakeupTime timeIntervalSinceDate:self.bedTime];

  [self ensureFormatter];
  int hours, minutes;
  hours = self.asleepSecondsInLastCycle / 60 / 60;
  minutes = (self.asleepSecondsInLastCycle - hours * 60 * 60) / 60;
  self.hoursOfSleepDisplay.text = [NSString stringWithFormat:@"%d:%02d", hours, minutes];
  NSLog(@"asleepSeconds: %g", self.asleepSecondsInLastCycle);
  self.hoursOfSleepDisplay.hidden = NO;
  self.sleeping = NO;
}

@end
