//
//  AddEntryViewController.m
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "AddEntryViewController.h"

@interface AddEntryViewController ()

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
