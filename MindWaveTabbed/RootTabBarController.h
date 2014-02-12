//
//  RootTabBarController.h
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGAccessoryManager.h"
#import "TGAccessoryDelegate.h"
#import <ExternalAccessory/ExternalAccessory.h>



@class BrainDataHistoryDocument;

@interface RootTabBarController : UITabBarController

@property (strong, nonatomic) BrainDataHistoryDocument
*brainDataHistoryDocument;



@end
