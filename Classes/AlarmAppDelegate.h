//
//  AlarmAppDelegate.h
//  Alarm
//
//  Created by François Beausoleil on 10-11-23.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmViewController;

@interface AlarmAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AlarmViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AlarmViewController *viewController;

@end

