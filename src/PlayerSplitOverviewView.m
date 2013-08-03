//
//  PlayerSplitOverviewView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "PlayerSplitOverviewView.h"

@interface PlayerSplitOverviewView()
{
    int werewolves;
    BOOL hunter;
    BOOL healer;
}
@end

@implementation PlayerSplitOverviewView

- (void) setWerewolves:(int)w
{
    werewolves = w;
    [self refresh];
}

- (void) setHunter:(BOOL)h
{
    hunter = h;
    [self refresh];
}

- (void) setHealer:(BOOL)h
{
    healer = h;
    [self refresh];
}
    
- (UIImage *) iconForPosition:(int)position
{
    if     (werewolves               > position) return [UIImage imageNamed:@"personIcon_red.png"];
    else if(werewolves+hunter        > position) return [UIImage imageNamed:@"personIcon_brown.png"];
    else if(werewolves+hunter+healer > position) return [UIImage imageNamed:@"personIcon_blue.png"];
    else                                         return [UIImage imageNamed:@"personIcon_green.png"];
}

@end
