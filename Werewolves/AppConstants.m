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

#define C_AWAKE 0
#define C_SLEEP 1
#define C_DEAD 2

#define C_DOT 0
#define C_PLAYER 1

@implementation AppConstants

@synthesize MAX_NUM_PLAYERS;

@synthesize VILLAGER;
@synthesize WEREWOLF;
@synthesize HUNTER;
@synthesize HEALER;

@synthesize AWAKE;
@synthesize SLEEP;
@synthesize DEAD;

@synthesize DOT;
@synthesize PLAYER;

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
        
        AWAKE = C_AWAKE;
        SLEEP = C_SLEEP;
        DEAD = C_DEAD;
        
        DOT = C_DOT;
        PLAYER = C_PLAYER;
    }
    return self;
}

@end
