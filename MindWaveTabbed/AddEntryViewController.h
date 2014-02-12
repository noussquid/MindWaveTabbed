//
//  AddEntryViewController.h
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGAccessoryManager.h"
#import "TGAccessoryDelegate.h"
#import <ExternalAccessory/ExternalAccessory.h>

// the eSense values
typedef struct {
    int attention;
    int meditation;
} ESenseValues;


@interface AddEntryViewController : UIViewController <TGAccessoryDelegate> {
    
    ESenseValues eSenseValues;
    NSThread * updateThread;
    
}

@property (assign, nonatomic, readonly) int durationInMinutes;
@property (assign, nonatomic, readonly) int meditation;
@property (strong, nonatomic, readonly) NSDate *date;

@property (weak, nonatomic, readonly) UIDatePicker *meditationTimer;
@property(nonatomic, readonly) NSTimeInterval countDownDuration;

@property (weak, nonatomic) IBOutlet UILabel *meditationLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;

// TGAccessoryDelegate protocol methods
- (void)accessoryDidConnect:(EAAccessory *)accessory;
- (void)accessoryDidDisconnect;
- (void)dataReceived:(NSDictionary *)data;


@end
