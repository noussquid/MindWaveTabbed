//
//  BrainDataEntry.h
//  MindWaveTabbed
//
//  Created by tester on 2/6/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrainDataUnits.h"

@interface BrainDataEntry : NSObject

/// Stores the average meditation value for this entry in US pounds
@property (assign, nonatomic, readonly) int meditationValue;

/// Stores the average attention value for this entry in US pounds
@property (assign, nonatomic, readonly) int durationInMinutes;

/// Stores the date for this entry
@property (strong, nonatomic, readonly) NSDate* date;

/**
 * Convenience method for instantiating new BrainDataEntry objects
 *
 * @param attentionValue Weight for this entry
 * @param unit Unit type for the weight parameter
 * @param date Date for this entry
 * @return A newly instantiated WeightEntry object
 */
+ (instancetype)entryWithBrainData:(int)meditation
                      withDuration:(int)durationInMinutes
                        forDate:(NSDate *)date;


@end
