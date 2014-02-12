//
//  BackgroundView.h
//  MindWaveTabbed
//
//  Created by tester on 2/10/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundView : UIView

@property (assign, nonatomic) CGFloat gridSpacing;
@property (assign, nonatomic) CGFloat gridLineWidth;
@property (assign, nonatomic) CGFloat gridXOffset;
@property (assign, nonatomic) CGFloat gridYOffset;
@property (strong, nonatomic) UIColor *gridLineColor;

@end
