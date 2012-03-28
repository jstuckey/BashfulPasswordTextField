//
//  ViewController.m
//  Bashful Pass Demo
//
//  Created by Jeremy Stuckey on 3/23/12.
//  Copyright (c) 2012 Jeremy Stuckey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize bashfulPassTextField;
@synthesize bashfulSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [bashfulPassTextField setIsBashful:YES]; 
}

- (void)viewDidUnload
{
    [self setBashfulPassTextField:nil];
    [self setBashfulSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    [bashfulPassTextField release];
    [bashfulSwitch release];
    [super dealloc];
}

- (IBAction)switchValueChanged:(id)sender {
    [bashfulPassTextField setIsBashful:[(UISwitch *)sender isOn]];
}

@end
