//
//  EntryDetailViewController.h
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrainDataEntry;

@interface EntryDetailViewController : UITableViewController
@property (strong, nonatomic) BrainDataEntry *entry;
@end
