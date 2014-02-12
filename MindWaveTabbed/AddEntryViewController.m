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
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
- (IBAction)startButton:(id)sender;

@end

@implementation AddEntryViewController {
    
    bool start;
    NSTimeInterval secondsLeft;
}

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
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    TGAccessoryType accessoryType = (TGAccessoryType)[defaults integerForKey:@"accessory_type_preference"];
    
    [[TGAccessoryManager sharedTGAccessoryManager] setupManagerWithInterval:0.2 forAccessoryType:accessoryType];
    [[TGAccessoryManager sharedTGAccessoryManager] setDelegate:self];

    [super viewDidLoad];
    
    start = false;
    
    self.date = [NSDate date];
    [self.meditationTimer setDatePickerMode:UIDatePickerModeCountDownTimer];
    
    
    self.meditationTimer.hidden = NO;
    self.countDownLabel.enabled = YES;
    
    // Select 1 minute by default
    self.durationInMinutes = 1;
    self.countDownDuration = 1 * 60;
    [self.meditationTimer setCountDownDuration:self.countDownDuration];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if([[TGAccessoryManager sharedTGAccessoryManager] accessory] != nil)
        [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    
    if(updateThread == nil) {
        updateThread = [[NSThread alloc] initWithTarget:self selector:@selector(updateLog) object:nil];
        [updateThread start];
    }

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

- (void)updateLog
{
    NSLog(@"We are logging bitches!");
}


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
   if ( [self.meditationTimer countDownDuration]  > 60  )
       self.durationInMinutes = [self.meditationTimer countDownDuration] / 60;
    else
        self.durationInMinutes = 1;
}

- (void)enableSaveButton
{
    BOOL enabled = YES;
    self.saveButton.enabled = enabled;
}


- (void)update
{
    if (start == false) {
        return;
    }
    
    NSLog(@"Seconds Left %f", secondsLeft);
    
    NSInteger m = floor(secondsLeft/60);
    NSInteger s = round(secondsLeft - m * 60);
    
    
    self.countDownLabel.text = [NSString stringWithFormat:@"%d:%02d", m, s];
    
    if ( secondsLeft == 0 )
        return;
    
    secondsLeft = secondsLeft - 1;
    
    [self performSelector:@selector(update) withObject:self afterDelay:1.0];
    
    
}

- (IBAction)startButton:(id)sender {
    
    if (start == false) {
        start = true;
        
        secondsLeft = self.meditationTimer.countDownDuration;
        NSLog(@"seconds left %f", secondsLeft);
        
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        
        self.meditationTimer.hidden = YES;
        
        self.countDownLabel.hidden = NO;
        
        [self update];
        
    } else
    {
        [[TGAccessoryManager sharedTGAccessoryManager] teardownManager];
        
        start = false;
        self.meditationTimer.hidden = NO;
        self.countDownLabel.hidden = YES;
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }

    
}

#pragma mark TGAccessoryDelegate protocol methods

- (void)accessoryDidConnect:(EAAccessory *)accessory {
    
    if (start)
        // start the data stream to the accessory
        [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    
}

- (void)accessoryDidDisconnect {
    
    NSLog(@"MindWave Disconnected");
}

- (void)dataReceived:(NSDictionary *)data {
    
    if([data valueForKey:@"eSenseAttention"]) {
        
        eSenseValues.attention =    [[data valueForKey:@"eSenseAttention"] intValue];
        eSenseValues.meditation =   [[data valueForKey:@"eSenseMeditation"] intValue];
        
        self.meditationLabel.text = [NSString stringWithFormat:@"%d", eSenseValues.meditation];
        self.attentionLabel.text = [NSString stringWithFormat:@"%d",eSenseValues.attention];
        
    }
}



@end
