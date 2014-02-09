//
//  BrainDataEntry.m
//  MindWaveTabbed
//
//  Created by tester on 2/6/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "BrainDataEntry.h"

@implementation BrainDataEntry
// Designated initializer.
- (id) initWithBrainData:(int)meditation
           withDuration:(int)minutes
              forDate:(NSDate*)date
{
    self = [super init];
    if (self)
    {
        _meditationValue = meditation;
        _durationInMinutes = minutes;
        _date = date;
    }
    return self;
}

// Must override the superclass's designated initializer.
- (id)init
{
    NSDate* referenceDate = [NSDate dateWithTimeIntervalSince1970:0.0f];
    
    return [self initWithBrainData:0
                     withDuration:0
                        forDate:referenceDate];
}

+(instancetype)entryWithBrainData:(int)meditation
                    withDuration:(int)minutes
                       forDate:(NSDate *)date
{
    return [[self alloc] initWithBrainData:meditation withDuration:minutes forDate:date];
}

#pragma mark - NSObject Methods

-(NSString *)description
{
    NSString *date = [NSDateFormatter
                      localizedStringFromDate:self.date
                      dateStyle:NSDateFormatterMediumStyle
                      timeStyle:NSDateFormatterShortStyle];
    
    return [NSString stringWithFormat:@"Meditation from %@", date];
}

@end
