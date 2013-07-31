//
//  TypePickerViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/21/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "TypePickerViewController.h"

@implementation TypePickerViewController

@synthesize titleLabel;
@synthesize numLeftLabel;
@synthesize done;
@synthesize campFireCircle;
@synthesize numLeft;
@synthesize state;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (IBAction)backButtonPressed
{
    if(self.state == C_WEREWOLF_PICKER)
    {
        for(int x = 0; x < [Game instance].numPlayers; x++)
        {
            ((Player *)[[Game instance].players objectAtIndex:x]).type = C_VILLAGER;
            ((Player *)[[Game instance].players objectAtIndex:x]).show = C_VILLAGER;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(self.state == C_HUNTER_PICKER)
    {
        for(int x = 0; x < [Game instance].numPlayers; x++)
        {
            if(((Player *)[[Game instance].players objectAtIndex:x]).type == C_HUNTER) 
            {
                ((Player *)[[Game instance].players objectAtIndex:x]).type = C_VILLAGER;
                ((Player *)[[Game instance].players objectAtIndex:x]).show = C_VILLAGER;
                [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
            }
        }
        self.titleLabel.text = @"Pick your Werewolves";
        self.numLeft = 0;
        self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
        self.done.hidden = NO;
        self.state = C_WEREWOLF_PICKER;
    }
    else if(self.state == C_HEALER_PICKER)
    {
        for(int x = 0; x < [Game instance].numPlayers; x++)
        {
            if(((Player *)[[Game instance].players objectAtIndex:x]).type == C_HEALER) 
            {
                ((Player *)[[Game instance].players objectAtIndex:x]).type = C_VILLAGER;
                ((Player *)[[Game instance].players objectAtIndex:x]).show = C_VILLAGER;
                [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
            }
        }
        if([Game instance].hunter)
        {
            self.titleLabel.text = @"Pick your Werewolves";
            self.numLeft = 0;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.done.hidden = NO;
            self.state = C_HUNTER_PICKER;
        }
        else
        {
            self.titleLabel.text = @"Pick your Hunter";
            self.numLeft = 0;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.done.hidden = NO;
            self.state = C_WEREWOLF_PICKER;
        }
    }
}

- (IBAction)diceButtonPressed
{
    int prob;
    int tempPlayersLeft;
    
    if(self.state == C_WEREWOLF_PICKER)
    {
        self.numLeft = [Game instance].numWerewolves;
        tempPlayersLeft = [Game instance].numPlayers;
        
        for(int x = 0; x < [Game instance].numPlayers; x++)
        {
            prob = arc4random() % tempPlayersLeft;
            if(prob < self.numLeft)
            {
                ((Player *)[[Game instance].players objectAtIndex:x]).type = C_WEREWOLF;
                ((Player *)[[Game instance].players objectAtIndex:x]).show = C_WEREWOLF;
                [self.campFireCircle turnPerson:x into:C_WEREWOLF animated:NO];
                self.numLeft--;
            }
            else
            {
                ((Player *)[[Game instance].players objectAtIndex:x]).type = C_VILLAGER;
                ((Player *)[[Game instance].players objectAtIndex:x]).show = C_VILLAGER;
                [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
            }
            tempPlayersLeft--;
        }
    }
    else if(self.state == C_HUNTER_PICKER)
    {
        self.numLeft = 1;
        tempPlayersLeft = [Game instance].numPlayers - [Game instance].numWerewolves;
        
        for(int x = 0; x < [Game instance].numPlayers; x++)
        {
            if(((Player *)[[Game instance].players objectAtIndex:x]).type != C_WEREWOLF)
            {
                prob = arc4random() % tempPlayersLeft;
                if(prob < self.numLeft)
                {
                    ((Player *)[[Game instance].players objectAtIndex:x]).type = C_HUNTER;
                    ((Player *)[[Game instance].players objectAtIndex:x]).show = C_HUNTER;
                    [self.campFireCircle turnPerson:x into:C_HUNTER animated:NO];
                    self.numLeft--;
                }
                else
                {
                    ((Player *)[[Game instance].players objectAtIndex:x]).type = C_VILLAGER;
                    ((Player *)[[Game instance].players objectAtIndex:x]).show = C_VILLAGER;
                    [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
                }
                tempPlayersLeft--;
            }
        }
    }
    else if(self.state == C_HEALER_PICKER)
    {
        self.numLeft = 1;
        tempPlayersLeft = [Game instance].numPlayers - [Game instance].numWerewolves;
        if([Game instance].hunter) tempPlayersLeft--;
        
        for(int x = 0; x < [Game instance].numPlayers; x++)
        {
            if(((Player *)[[Game instance].players objectAtIndex:x]).type != C_WEREWOLF && ((Player *)[[Game instance].players objectAtIndex:x]).type != C_HUNTER)
            {
                prob = arc4random() % tempPlayersLeft;
                if(prob < self.numLeft)
                {
                    ((Player *)[[Game instance].players objectAtIndex:x]).type = C_HEALER;
                    ((Player *)[[Game instance].players objectAtIndex:x]).show = C_HEALER;
                    [self.campFireCircle turnPerson:x into:C_HEALER animated:NO];
                    self.numLeft--;
                }
                else
                {
                    ((Player *)[[Game instance].players objectAtIndex:x]).type = C_VILLAGER;
                    ((Player *)[[Game instance].players objectAtIndex:x]).show = C_VILLAGER;
                    [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
                }
                tempPlayersLeft--;
            }
        }
    }
    
    self.numLeft = 0;
    self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
    self.done.hidden = NO;
}

- (void)pushNextViewController
{
    for(int x = 0; x < [Game instance].numPlayers; x++)
    {
        ((Player *)[[Game instance].players objectAtIndex:x]).show = C_VILLAGER;
    }
}

- (IBAction)doneButtonPressed
{
    if(self.state == C_WEREWOLF_PICKER)
    {
        if([Game instance].hunter)
        {
            self.titleLabel.text = @"Pick your Hunter";
            self.numLeft = 1;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.done.hidden = YES;
            self.state = C_HUNTER_PICKER;
        }
        else if([Game instance].healer)
        {  
            self.titleLabel.text = @"Pick your Healer";
            self.numLeft = 1;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.done.hidden = YES;
            self.state = C_HEALER_PICKER;
        }
        else
        {
            [self pushNextViewController];
        }
    }
    else if(self.state == C_HUNTER_PICKER)
    {
        if([Game instance].healer)
        {
            self.titleLabel.text = @"Pick your Healer";
            self.numLeft = 1;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.done.hidden = YES;
            self.state = C_HEALER_PICKER;
        }
        else
        {
            [self pushNextViewController];
        }
        
    }
    else if(self.state == C_HEALER_PICKER)
    {
        [self pushNextViewController];

    }
}

- (void)player:(int)person WasTouchedWhilePicking:(int)type
{
    if(((Player *)[[Game instance].players objectAtIndex:person]).type == type)
    {
        self.numLeft++;
        self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
        ((Player *)[[Game instance].players objectAtIndex:person]).type = C_VILLAGER;
        ((Player *)[[Game instance].players objectAtIndex:person]).show = C_VILLAGER;
        [self.campFireCircle turnPerson:person into:C_VILLAGER animated:NO];
        self.done.hidden = YES;
    }
    else if(((Player *)[[Game instance].players objectAtIndex:person]).type == C_VILLAGER)
    {
        if(self.numLeft > 0)
        {
            self.numLeft--;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            ((Player *)[[Game instance].players objectAtIndex:person]).type = type;
            ((Player *)[[Game instance].players objectAtIndex:person]).show = type;
            [self.campFireCircle turnPerson:person into:type animated:NO];
            if(self.numLeft == 0) self.done.hidden = NO;
        }
    }
}

- (void)personWasTouched:(int)person
{
    if(self.state == C_WEREWOLF_PICKER)
    {
        [self player:person WasTouchedWhilePicking:C_WEREWOLF];
    }
    else if(self.state == C_HUNTER_PICKER)
    {
        [self player:person WasTouchedWhilePicking:C_HUNTER];
    }
    else if(self.state == C_HEALER_PICKER)
    {
        [self player:person WasTouchedWhilePicking:C_HEALER];
    }
}



#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPinchGestureRecognizer *pinchZoom = [[UIPinchGestureRecognizer alloc] initWithTarget:self.campFireCircle action:@selector(handlePinchGesture:)];
    [self.campFireCircle addGestureRecognizer:pinchZoom];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.campFireCircle action:@selector(handlePanGesture:)];
    [self.campFireCircle addGestureRecognizer:pan];
    
    self.state = C_WEREWOLF_PICKER;
    self.titleLabel.text = @"Pick Your Werewolves";
    self.numLeft = [Game instance].numWerewolves;
    self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
    self.campFireCircle.delegate = self;
    self.done.hidden = YES;
}

@end
