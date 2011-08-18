//
//  Game.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "Game.h"


@implementation Game

@synthesize numPlayers;
@synthesize numWerewolves;
@synthesize numWerewolvesLeftToBePicked;
@synthesize hunter;
@synthesize hunterPicked;
@synthesize healer;
@synthesize healerPicked;
@synthesize day;
@synthesize daysPassed;
@synthesize turn;
@synthesize players;

static Game* singletonInstance = nil;

+ (Game *) instance {
    @synchronized([Game class])
	{
		if (!singletonInstance) singletonInstance = [[self alloc] init];
		return singletonInstance;
	}
	return nil;
}

- (id) init {
    if((self == [super init])){
        self.numPlayers = 10;
        self.numWerewolves = 3;
        self.numWerewolvesLeftToBePicked = 3;
        self.hunter = NO;
        self.hunterPicked = NO;
        self.healer = NO;
        self.healerPicked = NO;
        self.day = YES;
        self.daysPassed = 0;
        self.turn = [AppConstants instance].VILLAGER;
        self.players = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
