//
//  BrainDataEntry.m
//  MindWaveTabbed
//
//  Created by tester on 2/6/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "BrainDataEntry.h"

static NSNumberFormatter* formatter;

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

+ (void)initialize
{
    if (self == [BrainDataEntry class])
    {
        formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMinimum:[NSNumber numberWithInt:0]];
        [formatter setMaximumFractionDigits:2];
    }
}

+ (NSString*)stringForMeditation:(int)meditation
{
    NSString* meditationString =
    [formatter stringFromNumber:@(meditation)];
    
    return [NSString stringWithFormat:@"%@",
            meditationString];
}

- (NSString*)stringForMeditation:(int)meditation
{
    return [BrainDataEntry stringForMeditation:[self meditationValue]];
}

- (NSString*)stringForDuration:(int)duration
{
    return [BrainDataEntry stringForDuration:[self durationInMinutes]];
}

+ (NSString*)stringForDuration:(int)duration
{
    NSString* durationString =
    [formatter stringFromNumber:@(duration)];
    
    return [NSString stringWithFormat:@"%@",
            durationString];
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
