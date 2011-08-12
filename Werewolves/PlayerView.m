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
    
    if(newType == [AppConstants instance].VILLAGER)
    {
        if(newState == [AppConstants instance].AWAKE)
            [self setImage:[UIImage imageNamed:@"villager.png"]];
        else if(newState == [AppConstants instance].SLEEP)
            [self setImage:[UIImage imageNamed:@"villager_sleep.png"]];
        else if(newState == [AppConstants instance].DEAD)
            [self setImage:[UIImage imageNamed:@"villager_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"imagenotfound.png"]];
    }
    else if(newType == [AppConstants instance].WEREWOLF)
    {
        if(newState == [AppConstants instance].AWAKE)
            [self setImage:[UIImage imageNamed:@"werewolf.png"]];
        else if(newState == [AppConstants instance].SLEEP)
            [self setImage:[UIImage imageNamed:@"werewolf_sleep.png"]];
        else if(newState == [AppConstants instance].DEAD)
            [self setImage:[UIImage imageNamed:@"werewolf_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"imagenotfound.png"]];
    }
    else if(newType == [AppConstants instance].HUNTER)
    {
        if(newState == [AppConstants instance].AWAKE)
            [self setImage:[UIImage imageNamed:@"hunter.png"]];
        else if(newState == [AppConstants instance].SLEEP)
            [self setImage:[UIImage imageNamed:@"hunter_sleep.png"]];
        else if(newState == [AppConstants instance].DEAD)
            [self setImage:[UIImage imageNamed:@"hunter_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"imagenotfound.png"]];
    }
    else if(newType == [AppConstants instance].HEALER)
    {
        if(newState == [AppConstants instance].AWAKE)
            [self setImage:[UIImage imageNamed:@"healer.png"]];
        else if(newState == [AppConstants instance].SLEEP)
            [self setImage:[UIImage imageNamed:@"healer_sleep.png"]];
        else if(newState == [AppConstants instance].DEAD)
            [self setImage:[UIImage imageNamed:@"healer_dead.png"]];
        else
            [self setImage:[UIImage imageNamed:@"imagenotfound.png"]];
    }
    else
        [self setImage:[UIImage imageNamed:@"imagenotfound.png"]];
    
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    [super dealloc];
}

@end
