//
//  AppConstants.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/3/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "AppConstants.h"

#define C_MAX_NUM_PLAYERS 30

#define C_VILLAGER 0
#define C_WEREWOLF 1
#define C_HUNTER 2
#define C_HEALER 3

#define C_WEREWOLF_PICKER 1
#define C_HUNTER_PICKER 2
#define C_HEALER_PICKER 3

#define C_VILLAGER_TURN 0
#define C_WEREWOLF_TURN 1
#define C_HUNTER_TURN 2
#define C_HEALER_TURN 3

#define C_AWAKE 0
#define C_SLEEP 1
#define C_DEAD 2

#define C_DOT 0
#define C_PLAYER_GREEN 1
#define C_PLAYER_RED 2
#define C_PLAYER_BROWN 3
#define C_PLAYER_BLUE 4

@implementation AppConstants

@synthesize MAX_NUM_PLAYERS;

@synthesize VILLAGER;
@synthesize WEREWOLF;
@synthesize HUNTER;
@synthesize HEALER;

@synthesize WEREWOLF_PICKER;
@synthesize HUNTER_PICKER;
@synthesize HEALER_PICKER;

@synthesize VILLAGER_TURN;
@synthesize WEREWOLF_TURN;
@synthesize HUNTER_TURN;
@synthesize HEALER_TURN;

@synthesize AWAKE;
@synthesize SLEEP;
@synthesize DEAD;

@synthesize DOT;
@synthesize PLAYER_GREEN;
@synthesize PLAYER_RED;
@synthesize PLAYER_BROWN;
@synthesize PLAYER_BLUE;

static AppConstants* singletonInstance = nil;

+ (AppConstants *) instance {
    @synchronized([AppConstants class])
	{
		if (!singletonInstance) singletonInstance = [[self alloc] init];
		return singletonInstance;
	}
	return nil;
}

- (id) init {
    if((self == [super init])){
        MAX_NUM_PLAYERS = C_MAX_NUM_PLAYERS;
        
        VILLAGER = C_VILLAGER;
        WEREWOLF = C_WEREWOLF;
        HUNTER = C_HUNTER;
        HEALER = C_HEALER;
        
        WEREWOLF_PICKER = C_WEREWOLF_PICKER;
        HUNTER_PICKER = C_HUNTER_PICKER;
        HEALER_PICKER = C_HEALER_PICKER;
        
        VILLAGER_TURN = C_VILLAGER_TURN;
        WEREWOLF_TURN = C_WEREWOLF_TURN;
        HUNTER_TURN = C_HUNTER_TURN;
        HEALER_TURN = C_HEALER_TURN;
        
        AWAKE = C_AWAKE;
        SLEEP = C_SLEEP;
        DEAD = C_DEAD;
        
        DOT = C_DOT;
        PLAYER_GREEN = C_PLAYER_GREEN;
        PLAYER_RED = C_PLAYER_RED;
        PLAYER_BROWN = C_PLAYER_BROWN;
        PLAYER_BLUE = C_PLAYER_BLUE;
    }
    return self;
}

@end
