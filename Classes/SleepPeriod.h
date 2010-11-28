//
//  SleepPeriod.h
//  Alarm
//
//  Created by François Beausoleil on 10-11-25.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SleepPeriod : NSObject {
  NSDate *bedtime;
  NSDate *wakeuptime;
}

@property (nonatomic, copy) NSDate *bedtime;
@property (nonatomic, copy) NSDate *wakeuptime;
@property (readonly) NSTimeInterval durationInSeconds;
@property (readonly) NSString *durationInHoursMinutes;

-(NSTimeInterval)durationInSeconds;
-(NSString *)durationInHoursMinutes;

-(void)gotoBed;
-(void)wakeup;

+(SleepPeriod *)initWithBedtimeToNow;

@end
