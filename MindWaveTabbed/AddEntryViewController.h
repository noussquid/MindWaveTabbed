//
//  AddEntryViewController.h
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEntryViewController : UIViewController

@property (assign, nonatomic, readonly) int durationInMinutes;
@property (assign, nonatomic, readonly) int meditation;
@property (strong, nonatomic, readonly) NSDate *date;

@property (weak, nonatomic, readonly) UIDatePicker *meditationTimer;
@property(nonatomic, readonly) NSTimeInterval countDownDuration;

@end
