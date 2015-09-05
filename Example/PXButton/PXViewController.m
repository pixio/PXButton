//
//  PXViewController.m
//  PXButton
//
//  Created by Daniel Blakemore on 05/01/2015.
//  Copyright (c) 2014 Daniel Blakemore. All rights reserved.
//

#import "PXViewController.h"
#import "PXView.h"

@interface PXViewController ()

@end

@implementation PXViewController

- (void)loadView
{
    [self setView:[[PXView alloc] init]];
}

- (PXView*)contentView
{
    return (PXView*)[self view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"PX Button"];
    
    [[self view] setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    // Modify the colors of the navigation
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor orangeColor]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    // Add targets for button presses
    [[[self contentView] jakeButton] addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
    [[[self contentView] finnButton] addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pressed:(UIButton*) button
{
    // When pressed, randomly change the tint
    [button setImage:[[button imageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithHue:drand48() saturation:1 brightness:1 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
