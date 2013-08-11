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
@synthesize day;
@synthesize daysPassed;
@synthesize turnState;
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
        self.day = YES;
        self.daysPassed = 0;
        self.turnState = C_VILLAGER_TURN;
        self.players = [[NSMutableArray alloc] initWithCapacity:30];
        self.history = [[NSMutableArray alloc] initWithCapacity:30];
    }
    return self;
}

- (int) maxWerewolves
{
    return (self.numPlayers/2)-1;
}

@end
