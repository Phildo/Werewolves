//
//  Game.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"


@interface Game : NSObject {
    int numPlayers;
    int numWerewolves;
    int numWerewolvesLeftToBePicked;
    BOOL hunter;
    BOOL hunterPicked;
    BOOL healer;
    BOOL healerPicked;
    BOOL day;
    int daysPassed;
    int turn;
    NSMutableArray *players;
}

@property int numPlayers;
@property int numWerewolves;
@property int numWerewolvesLeftToBePicked;
@property BOOL hunter;
@property BOOL hunterPicked;
@property BOOL healer;
@property BOOL healerPicked;
@property BOOL day;
@property int daysPassed;
@property int turn;
@property (retain) NSMutableArray *players;

+ (Game *) instance;

@end
