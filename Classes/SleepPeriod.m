//
//  SleepPeriod.m
//  Alarm
//
//  Created by François Beausoleil on 10-11-25.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import "SleepPeriod.h"


@implementation SleepPeriod

@synthesize bedtime, wakeuptime;

+(SleepPeriod *)initWithBedtimeToNow {
  SleepPeriod *sp = [[[SleepPeriod alloc] init] autorelease];
  [sp gotoBed];
  return sp;
}

-(void)gotoBed {
  self.bedtime = [NSDate date];
}

-(void)wakeup {
  self.wakeuptime = [NSDate date];
}

-(NSTimeInterval)durationInSeconds {
  return [self.wakeuptime timeIntervalSinceDate: self.bedtime];
}

-(NSUInteger)durationInHours {
  return [self durationInSeconds] / 60 / 60;
}

-(NSUInteger)durationInMinutes {
  return ([self durationInSeconds] / 60) - ([self durationInHours] * 60);
}

-(NSString *)durationInHoursMinutes {
  return [NSString stringWithFormat:@"%d:%02d", [self durationInHours], [self durationInMinutes]];
}

-(NSString *)description {
  return [NSString stringWithFormat:@"%@ / %@", self.bedtime, self.wakeuptime];
}

@end
