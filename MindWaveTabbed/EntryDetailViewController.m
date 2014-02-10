//
//  EntryDetailViewController.m
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "EntryDetailViewController.h"
#import "BrainDataEntry.h"

@interface EntryDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *durationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTopScore;
@property (weak, nonatomic) IBOutlet UITextField *monthTopScoreDuration;
@property (weak, nonatomic) IBOutlet UITextField *monthTotalTime;

@end

@implementation EntryDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

// TODO: Delete This After Testing!
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@ appeared", [self class]);
}

#pragma mark - Private Methods

- (void)updateUI
{
    self.scoreTextField.text =
    [self.entry stringForMeditation:[self.entry meditationValue]];
    
    self.durationTextField.text = [self.entry stringForDuration:[self.entry durationInMinutes]];
                                   
    self.dateTextField.text =
    [NSDateFormatter localizedStringFromDate:self.entry.date
                                   dateStyle:NSDateFormatterMediumStyle
                                   timeStyle:NSDateFormatterShortStyle];
    
    int topScore =
    [[self.lastMonthsEntries valueForKeyPath:@"@max.meditationValue"] intValue];
    
    int duration =
    [[self.lastMonthsEntries valueForKeyPath:@"@max.durationInMinutes"] intValue];
    
    int totalTime =
    [[self.lastMonthsEntries valueForKeyPath:@"@sum.durationInMinutes"] intValue];

   
    self.monthTopScore.text = [BrainDataEntry stringForMeditation:topScore];
    
    self.monthTopScoreDuration.text = [BrainDataEntry stringForMeditation:duration];
    
    self.monthTotalTime.text = [BrainDataEntry stringForMeditation: totalTime];
    
}

@end
