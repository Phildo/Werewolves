//
//  Player.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/3/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize name;
@synthesize playerId;
@synthesize type;
@synthesize dayKilled;
@synthesize isAlive;
@synthesize isAwake;

- (id) init {
    if((self = [super init])){
        self.name = @"Player";
        self.type = [AppConstants instance].WEREWOLF;
        self.dayKilled = 0;
        self.isAlive = YES;
        self.isAwake = YES;
    }
    return self;
}

- (void) dealloc {
    [super dealloc];
    [name release];
}

@end
