//
//  AlarmViewController.h
//  Alarm
//
//  Created by François Beausoleil on 10-11-23.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController {
  UILabel *bedtimeDisplay;
  UILabel *hoursOfSleepDisplay;
  NSDateFormatter *formatter;
}

@property (nonatomic, assign) BOOL sleeping;
@property (nonatomic, copy) NSDate *bedTime;
@property (nonatomic, copy) NSDate *wakeupTime;
@property (nonatomic, assign) NSTimeInterval asleepSecondsInLastCycle;

@property (nonatomic, retain) IBOutlet UILabel *bedtimeDisplay;
@property (nonatomic, retain) IBOutlet UILabel *hoursOfSleepDisplay;

-(IBAction)goToBed:(id)sender;
-(IBAction)wakeUp:(id)sender;

@end

