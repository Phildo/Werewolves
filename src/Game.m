//
//  Game.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "Game.h"
#import "AppConstants.h"

@implementation Game

@synthesize numPlayers;
@synthesize numWerewolves;
@synthesize hunter;
@synthesize healer;
@synthesize state;
@synthesize players;
@synthesize history;

- (id) init
{
    if((self = [super init]))
    {
        self.numPlayers = 10;
        self.numWerewolves = 3;
        self.hunter = NO;
        self.healer = NO;
        self.state = C_NONE;
        self.players = [[NSMutableArray alloc] initWithCapacity:30];
        self.history = [[NSMutableArray alloc] initWithCapacity:30];
    }
    return self;
}

- (int) maxWerewolves
{
    return (self.numPlayers/2)-1;
}

- (int) nextState
{
    switch(self.state)
    {
        case C_VILLAGER:
            if(self.hunter) return C_HUNTER;
        case C_HUNTER:
            if(self.healer) return C_HEALER;
        case C_HEALER:
            return C_WEREWOLF;
            break;
        case C_WEREWOLF:
            return C_VILLAGER;
            break;
        default:
            return C_WEREWOLF;
            break;
    }
    return C_WEREWOLF;
}

@end
