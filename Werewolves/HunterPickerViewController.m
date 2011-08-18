//
//  HunterPickerViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/17/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "HunterPickerViewController.h"


@implementation HunterPickerViewController

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
        if(((Player *)[[Game instance].players objectAtIndex:x]).type == [AppConstants instance].HUNTER) ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].VILLAGER;
    }
    [Game instance].hunterPicked = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)diceButtonPressed
{
    int tempPlayersLeft = [Game instance].numPlayers - [Game instance].numWerewolves;
    int prob;
    [Game instance].hunterPicked = NO;
    
    for(int x = 0; x < [Game instance].numPlayers; x++)
    {
        if(((Player *)[[Game instance].players objectAtIndex:x]).type != [AppConstants instance].WEREWOLF)
        {
            prob = arc4random() % tempPlayersLeft;
            if(prob < 1 && ![Game instance].hunterPicked)
            {
                ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].HUNTER;
                [self.campFireCircle turnPerson:x into:[AppConstants instance].HUNTER animated:NO];
                [Game instance].hunterPicked = YES;
            }
            else
            {
                ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].VILLAGER;
                [self.campFireCircle turnPerson:x into:[AppConstants instance].VILLAGER animated:NO];
            }
            tempPlayersLeft--;
        }
    }
    self.done.hidden = NO;
}

- (IBAction)doneButtonPressed
{
    if([Game instance].healer)
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
    if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].HUNTER)
    {
        [Game instance].hunterPicked = NO;
        ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].VILLAGER;
        [self.campFireCircle turnPerson:person into:[AppConstants instance].VILLAGER animated:NO];
        self.done.hidden = YES;
    }
    else if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].VILLAGER)
    {
        if(![Game instance].hunterPicked)
        {
            [Game instance].hunterPicked = YES;
            ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].HUNTER;
            [self.campFireCircle turnPerson:person into:[AppConstants instance].HUNTER animated:NO];
            self.done.hidden = NO;
        }
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    self.campFireCircle.delegate = self;
    if([Game instance].hunterPicked) self.done.hidden = NO;
    else self.done.hidden = YES;
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
