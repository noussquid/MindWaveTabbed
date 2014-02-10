//
//  AddEntryViewController.m
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "AddEntryViewController.h"

@interface AddEntryViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *meditationTimer;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@property (assign, nonatomic, readwrite) int meditation;
@property (assign, nonatomic, readwrite) int durationInMinutes;
@property (strong, nonatomic, readwrite) NSDate *date;
@property(nonatomic) NSTimeInterval countDownDuration;

@end

@implementation AddEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// TODO: Delete This After Testing!
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@ appeared", [self class]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.date = [NSDate date];
    [self.meditationTimer setDatePickerMode:UIDatePickerModeCountDownTimer];
    
    // Select 1 minute by default
    self.countDownDuration = 1 * 60;
    [self.meditationTimer setCountDownDuration:self.countDownDuration];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
    [self.meditationTimer becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)durationValueChanged:(id)sender {
    
    [self durationSelectionDone];
}

#pragma mark - Private Methods

- (void)updateUI
{
    [self updateDateText];
    [self enableSaveButton];
}

- (void)updateDateText
{
    if (self.date == nil)
    {
        self.dateTextField.text = @"";
    }
    else
    {
        self.dateTextField.text =
        [NSDateFormatter
         localizedStringFromDate:self.date
         dateStyle:NSDateFormatterMediumStyle
         timeStyle:NSDateFormatterShortStyle];
        
        self.dateTextField.textColor =
        [UIColor blackColor];
    }
}

- (void)durationSelectionDone
{
   
   self.durationInMinutes = [self.meditationTimer countDownDuration] / 60;
}

- (void)enableSaveButton
{
    BOOL enabled = YES;
    self.saveButton.enabled = enabled;
}



@end
