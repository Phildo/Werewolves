//
//  Move.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/23/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "Move.h"


@implementation Move

@synthesize action;
@synthesize player;
@synthesize day;

- (id) initWithAction:(int)a ToPlayer:(int)p OnDay:(int)d 
{
    if((self = [super init])){
        self.action = a;
        self.player = p;
        self.day = d;
    }
    return self;
}

@end
