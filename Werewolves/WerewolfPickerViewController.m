//
//  WerewolfPickerViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "WerewolfPickerViewController.h"


@implementation WerewolfPickerViewController

@synthesize numLeft;
@synthesize numLeftLabel;
@synthesize done;
@synthesize campFireCircle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.numLeft = [Game instance].numWerewolves;
    }
    return self;
}

- (void)releaseOutlets
{
    self.numLeftLabel = nil;
}

- (void)dealloc
{
    [self releaseOutlets];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)diceButtonPressed
{
    
}

- (IBAction)doneButtonPressed
{

}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self releaseOutlets];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
