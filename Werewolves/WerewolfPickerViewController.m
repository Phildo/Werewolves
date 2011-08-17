//
//  WerewolfPickerViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "WerewolfPickerViewController.h"


@implementation WerewolfPickerViewController

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

- (int)numLeft
{
    return numLeft;
}

- (void)setNumLeft:(int)newNumLeft
{
    numLeft = newNumLeft;
    self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", numLeft];
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

- (void)personWasTouched:(int)person
{
    if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].WEREWOLF)
    {
        self.numLeft++;
        ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].VILLAGER;
        [self.campFireCircle turnPerson:person into:[AppConstants instance].VILLAGER animated:NO];
    }
    else if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].VILLAGER)
    {
        if(self.numLeft > 0)
        {
            self.numLeft--;
            ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].WEREWOLF;
            [self.campFireCircle turnPerson:person into:[AppConstants instance].WEREWOLF animated:NO];
        }
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
    self.campFireCircle.delegate = self;
    self.done.hidden = YES;
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
