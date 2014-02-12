//
//  RootTabBarController.m
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "RootTabBarController.h"
#import "BrainDataHistoryDocument.h"
#import "BrainDataEntry.h"


@interface RootTabBarController ()

@end

@implementation RootTabBarController

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
    self.brainDataHistoryDocument = [[BrainDataHistoryDocument alloc] init];
    [self addMockData];
    [self documentReady];
}


#pragma mark - Private Methods

- (void)documentReady
{
    // automatically passes the weight history document
    // on to any of the controlled view controllers.
    for (id controller in self.viewControllers) {
        if ([controller respondsToSelector:
             @selector(setBrainDataHistoryDocument:)])
        {
            [controller setBrainDataHistoryDocument:
             self.brainDataHistoryDocument];
        }
    }
}




- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
}


- (void)addMockData
{
    NSTimeInterval twentyFourHours = 60.0 * 60.0 * 24.0;
    NSDate *now = [NSDate date];
    
    NSDate *yesterday =
    [now dateByAddingTimeInterval:-twentyFourHours];
    
    NSDate *twoDaysAgo =
    [yesterday dateByAddingTimeInterval:-twentyFourHours];
    
    BrainDataEntry *entry1 =
    [BrainDataEntry entryWithBrainData:80 withDuration:10 forDate:twoDaysAgo];
    
    BrainDataEntry *entry2 =
    [BrainDataEntry entryWithBrainData:60 withDuration:5 forDate:yesterday];
    
    BrainDataEntry *entry3 =
    [BrainDataEntry entryWithBrainData:90 withDuration:10 forDate:now];
    
    [self.brainDataHistoryDocument addEntry:entry1];
    
    [self.brainDataHistoryDocument performSelector:@selector(addEntry:)
                                        withObject:entry2
                                        afterDelay:2.0];
    
    [self.brainDataHistoryDocument performSelector:@selector(addEntry:)
                                        withObject:entry3
                                        afterDelay:4.0];
}


@end
