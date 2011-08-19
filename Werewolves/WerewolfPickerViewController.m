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
    }
    return self;
}

- (void)releaseOutlets
{
    self.numLeftLabel = nil;
    self.campFireCircle = nil;
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
    for(int x = 0; x < [Game instance].numPlayers; x++)
    {
        ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].VILLAGER;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)diceButtonPressed
{
    int tempWerewolvesLeft = [Game instance].numWerewolves;
    int tempPlayersLeft = [Game instance].numPlayers;
    int prob;
    
    for(int x = 0; x < [Game instance].numPlayers; x++)
    {
        prob = arc4random() % tempPlayersLeft;
        if(prob < tempWerewolvesLeft)
        {
            ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].WEREWOLF;
            [self.campFireCircle turnPerson:x into:[AppConstants instance].WEREWOLF animated:NO];
            tempWerewolvesLeft--;
        }
        else
        {
            ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].VILLAGER;
            [self.campFireCircle turnPerson:x into:[AppConstants instance].VILLAGER animated:NO];
        }
        tempPlayersLeft--;
    }
    [Game instance].numWerewolvesLeftToBePicked = 0;
    self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", [Game instance].numWerewolvesLeftToBePicked];
    self.done.hidden = NO;
}

- (IBAction)doneButtonPressed
{
    if([Game instance].hunter)
    {
        HunterPickerViewController *hunterPicker = [[HunterPickerViewController alloc] init];
        [self.navigationController pushViewController:hunterPicker animated:NO];
        [hunterPicker release];
    }
    else if([Game instance].healer)
    {
        HealerPickerViewController *healerPicker = [[HealerPickerViewController alloc] init];
        [self.navigationController pushViewController:healerPicker animated:NO];
        [healerPicker release];
    }
    else
    {
        
    }
    
}

- (void)personWasTouched:(int)person
{
    if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].WEREWOLF)
    {
        [Game instance].numWerewolvesLeftToBePicked++;
        self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", [Game instance].numWerewolvesLeftToBePicked];
        ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].VILLAGER;
        [self.campFireCircle turnPerson:person into:[AppConstants instance].VILLAGER animated:NO];
        self.done.hidden = YES;
    }
    else if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].VILLAGER)
    {
        if([Game instance].numWerewolvesLeftToBePicked > 0)
        {
            [Game instance].numWerewolvesLeftToBePicked--;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", [Game instance].numWerewolvesLeftToBePicked];
            ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].WEREWOLF;
            [self.campFireCircle turnPerson:person into:[AppConstants instance].WEREWOLF animated:NO];
            if([Game instance].numWerewolvesLeftToBePicked == 0) self.done.hidden = NO;
        }
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", [Game instance].numWerewolvesLeftToBePicked];
    self.campFireCircle.delegate = self;
    if([Game instance].numWerewolvesLeftToBePicked == 0) self.done.hidden = NO;
    else self.done.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIPinchGestureRecognizer *pinchZoom = [[UIPinchGestureRecognizer alloc] initWithTarget:self.campFireCircle action:@selector(handlePinchGesture:)];
    [self.campFireCircle addGestureRecognizer:pinchZoom];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.campFireCircle action:@selector(handlePanGesture:)];
    [self.campFireCircle addGestureRecognizer:pan];
    [pinchZoom release];
    [pan release];
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
