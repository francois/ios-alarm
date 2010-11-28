//
//  PeriodsGraphView.h
//  Alarm
//
//  Created by François Beausoleil on 10-11-25.
//  Copyright 2010 Bloom Digital Platforms Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PeriodsGraphView : UIView {

}

@property (nonatomic, copy) NSArray *periods;

-(IBAction)changeNumberOfDaysToDisplay:(id)sender;

@end
