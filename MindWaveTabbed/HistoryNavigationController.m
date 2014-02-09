//
//  HistoryNavigationController.m
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "HistoryNavigationController.h"

@interface HistoryNavigationController ()

@end

@implementation HistoryNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

#pragma mark - Accessor Methods

-(void)setBrainDataHistoryDocument:
(BrainDataHistoryDocument *)brainDataHistoryDocument
{
    _brainDataHistoryDocument = brainDataHistoryDocument;
    
    id rootViewController = self.viewControllers[0];
    if ([rootViewController respondsToSelector:
         @selector(setBrainDataHistoryDocument:)])
    {
        [rootViewController setBrainDataHistoryDocument:
         brainDataHistoryDocument];
    }
}

@end
