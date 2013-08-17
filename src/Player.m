//
//  Player.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/3/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "Player.h"
#import "AppConstants.h"

@implementation Player

@synthesize name;
@synthesize type;
@synthesize state;

- (id) initWithName:(NSString *)n
{
    if((self = [super init]))
    {
        self.name = n ? n : @"Player";
        self.type = C_VILLAGER;
        self.state = C_AWAKE;
    }
    return self;
}

- (void) incrementType
{
    self.type = (type+1)%4;
}

- (void) wake
{
    self.state = C_AWAKE;
}

- (void) sleep
{
    self.state = C_SLEEP;
}

- (void) kill
{
    self.state = C_DEAD;
}

@end
