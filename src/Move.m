//
//  Move.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/23/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "Move.h"

@implementation Move

@synthesize player;
@synthesize type;

- (id) initWithType:(int)t player:(Player *)p
{
    if((self = [super init]))
    {
        self.player = p;
        self.type = t;
    }
    return self;
}

@end