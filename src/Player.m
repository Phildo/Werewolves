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
@synthesize show;
@synthesize state;
@synthesize dayKilled;

- (id) init {
    if((self = [super init])){
        self.name = @"Player";
        self.type = C_VILLAGER;
        self.show = C_VILLAGER;
        self.state = C_AWAKE;
        self.dayKilled = 0;
    }
    return self;
}

@end
