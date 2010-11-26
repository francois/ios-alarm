//
//  AlarmViewController.h
//  Alarm
//
//  Created by François Beausoleil on 10-11-23.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SleepPeriod;

@interface AlarmViewController : UIViewController {
  UILabel *bedtimeDisplay;
  UILabel *hoursOfSleepDisplay;
  NSDateFormatter *formatter;
}

@property (nonatomic, retain) SleepPeriod *currentPeriod;

@property (nonatomic, retain) IBOutlet UILabel *bedtimeDisplay;
@property (nonatomic, retain) IBOutlet UILabel *hoursOfSleepDisplay;

-(IBAction)goToBed:(id)sender;
-(IBAction)wakeUp:(id)sender;

@end

