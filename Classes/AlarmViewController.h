//
//  AlarmViewController.h
//  Alarm
//
//  Created by François Beausoleil on 10-11-23.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SleepPeriod, PeriodsGraphView;

@interface AlarmViewController : UIViewController {
  NSDateFormatter *formatter;
}

@property (nonatomic, retain) SleepPeriod *currentPeriod;
@property (nonatomic, copy) NSSet *periods;

@property (nonatomic, retain) IBOutlet UILabel *bedtimeDisplay;
@property (nonatomic, retain) IBOutlet UILabel *hoursOfSleepDisplay;
@property (nonatomic, retain) IBOutlet PeriodsGraphView *graphView;

-(IBAction)goToBed:(id)sender;
-(IBAction)wakeUp:(id)sender;

@end

