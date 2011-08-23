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

- (id) initWithAction:(int)a OnPlayer:(int)p {
    if((self = [super init])){
        self.action = a;
        self.player = p;
    }
    return self;
}

@end
