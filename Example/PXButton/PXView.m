//
//  PXView.m
//  PXButton
//
//  Created by Calvin Kern on 5/20/15.
//  Copyright (c) 2015 Daniel Blakemore. All rights reserved.
//

#import "PXView.h"

@implementation PXView
{
    PXButton* _jakeButton;
    PXButton* _finnButton;
    UIView* _centerView;
}

@synthesize jakeButton = _jakeButton;
@synthesize finnButton = _finnButton;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create the container view
        _centerView = [[UIView alloc] init];
        [_centerView setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [self addSubview:_centerView];

        // Create Jake button (upper button)
        _jakeButton = [[PXButton alloc] init];
        [_jakeButton setBackgroundColor:[UIColor greenColor]];
        [_jakeButton setUsesSubtleGradient:TRUE];
        [_jakeButton setImage:[UIImage imageNamed:@"jake"] atPosition:PXButtonIconPositionLeft forState:UIControlStateNormal tint:FALSE];
        [_jakeButton setTitle:@"Jake the Dog" forState:UIControlStateNormal];
        [_jakeButton setCornerRadius:4.0f];
        [_jakeButton setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [_centerView addSubview:_jakeButton];

        // Create Finn Button (lower button)
        _finnButton = [[PXButton alloc] init];
        [_finnButton setBackgroundColor:[UIColor orangeColor]];
        [_finnButton setUsesSubtleGradient:TRUE];
        [_finnButton setImage:[UIImage imageNamed:@"finn"] atPosition:PXButtonIconPositionRight forState:UIControlStateNormal tint:false];
        [_finnButton setTitle:@"Finn the Human" forState:UIControlStateNormal];
        [_finnButton setIconSize:40];
        [_finnButton setCornerRadius:4.0f];
        [_finnButton setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [_centerView addSubview:_finnButton];
        [[_finnButton titleLabel] setAdjustsFontSizeToFitWidth:TRUE];
        [[_finnButton titleLabel] setFont:[UIFont fontWithName:@"futura" size:18]];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    [self removeConstraints:[self constraints]];
    
    NSDictionary* views = NSDictionaryOfVariableBindings(_jakeButton, _finnButton, _centerView);
    NSDictionary* metrics = @{@"sp" : @60, @"bh" : @48};
    
    // Horizontal
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sp-[_centerView]-sp-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_jakeButton]|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_finnButton]|" options:0 metrics:metrics views:views]];
    
    // Vertical
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_jakeButton(bh)]-sp-[_finnButton(bh)]|" options:0 metrics:metrics views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [super updateConstraints];
}

@end
