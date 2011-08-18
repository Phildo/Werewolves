//
//  HealerPickerViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/18/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "HealerPickerViewController.h"


@implementation HealerPickerViewController

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
        if(((Player *)[[Game instance].players objectAtIndex:x]).type == [AppConstants instance].HEALER) ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].VILLAGER;
    }
    [Game instance].healerPicked = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)diceButtonPressed
{
    int tempPlayersLeft = [Game instance].numPlayers - [Game instance].numWerewolves;
    if([Game instance].hunter) tempPlayersLeft--;
    int prob;
    [Game instance].healerPicked = NO;
    
    for(int x = 0; x < [Game instance].numPlayers; x++)
    {
        if(((Player *)[[Game instance].players objectAtIndex:x]).type != [AppConstants instance].WEREWOLF && ((Player *)[[Game instance].players objectAtIndex:x]).type != [AppConstants instance].HUNTER)
        {
            prob = arc4random() % tempPlayersLeft;
            if(prob < 1 && ![Game instance].healerPicked)
            {
                ((Player *)[[Game instance].players objectAtIndex:x]).type = [AppConstants instance].HEALER;
                [self.campFireCircle turnPerson:x into:[AppConstants instance].HEALER animated:NO];
                [Game instance].healerPicked = YES;
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
    /*
     HealerPickerViewController *healerPicker = [[HealerPickerViewController alloc] init];
     [self.navigationController pushViewController:healerPicker animated:NO];
     [healerPicker release];
     */
}

- (void)personWasTouched:(int)person
{
    if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].HEALER)
    {
        [Game instance].healerPicked = NO;
        ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].VILLAGER;
        [self.campFireCircle turnPerson:person into:[AppConstants instance].VILLAGER animated:NO];
        self.done.hidden = YES;
    }
    else if(((Player *)[[Game instance].players objectAtIndex:person]).type == [AppConstants instance].VILLAGER)
    {
        if(![Game instance].healerPicked)
        {
            [Game instance].healerPicked = YES;
            ((Player *)[[Game instance].players objectAtIndex:person]).type = [AppConstants instance].HEALER;
            [self.campFireCircle turnPerson:person into:[AppConstants instance].HEALER animated:NO];
            self.done.hidden = NO;
        }
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    self.campFireCircle.delegate = self;
    if([Game instance].healerPicked) self.done.hidden = NO;
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
