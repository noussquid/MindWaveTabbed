//
//  BrainDataUnits.h
//  MindWaveTabbed
//
//  Created by tester on 2/6/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Delta,
    Theta,
    LowAlpha,
    HighAlpha,
    LowBeta,
    HighBeta,
    LowGamma,
    HighGamma
} EegBands;

EegBands getDefaultBand(void);