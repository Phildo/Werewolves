//
//  PlayerView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/4/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "PlayerView.h"


@implementation PlayerView

@synthesize delegate;
@synthesize idNum;
@synthesize type;
@synthesize state;
@synthesize faded;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)setAppearanceToType:(int)newType state:(int)newState faded:(BOOL)newFaded
{
    self.type = newType;
    self.state = newState;
    self.faded = newFaded;
    
    if(newType == C_VILLAGER)
    {
        if(newState == C_AWAKE)
            [self setImage:[UIImage imageNamed:@"villager.png"]];
        else if(newState == C_SLEEP)
            [self setImage:[UIImage imageNamed:@"villager_sleep.png"]];
        else if(newState == C_DEAD)
            [self setImage:[UIImage imageNamed:@"villager_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"img_not_found.png"]];
    }
    else if(newType == C_WEREWOLF)
    {
        if(newState == C_AWAKE)
            [self setImage:[UIImage imageNamed:@"werewolf.png"]];
        else if(newState == C_SLEEP)
            [self setImage:[UIImage imageNamed:@"werewolf_sleep.png"]];
        else if(newState == C_DEAD)
            [self setImage:[UIImage imageNamed:@"werewolf_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"img_not_found.png"]];
    }
    else if(newType == C_HUNTER)
    {
        if(newState == C_AWAKE)
            [self setImage:[UIImage imageNamed:@"hunter.png"]];
        else if(newState == C_SLEEP)
            [self setImage:[UIImage imageNamed:@"hunter_sleep.png"]];
        else if(newState == C_DEAD)
            [self setImage:[UIImage imageNamed:@"hunter_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"img_not_found.png"]];
    }
    else if(newType == C_HEALER)
    {
        if(newState == C_AWAKE)
            [self setImage:[UIImage imageNamed:@"healer.png"]];
        else if(newState == C_SLEEP)
            [self setImage:[UIImage imageNamed:@"healer_sleep.png"]];
        else if(newState == C_DEAD)
            [self setImage:[UIImage imageNamed:@"healer_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"img_not_found.png"]];
    }
    else
        [self setImage:[UIImage imageNamed:@"img_not_found.png"]];
    
    if(newFaded)
        [self setAlpha:.5];
    else
        [self setAlpha:1];
}

- (void)incrementType
{
    self.type++;
    if(self.type == 4)
        self.type = 0;
    
    [self setAppearanceToType:self.type state:self.state faded:self.faded];
}

- (void)dim:(BOOL)dim
{
    self.faded = dim;
    
    if(dim)
        [self setAlpha:.5];
    else
        [self setAlpha:1];
}

- (void)iWasTouched
{
    [delegate playerWasTouched:self];
}

- (void)iWasLongTouched:(UILongPressGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
        [delegate playerWasLongTouched:self];
}

@end
