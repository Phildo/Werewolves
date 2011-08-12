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
    BOOL hunter;
    BOOL healer;
    BOOL day;
    int daysPassed;
    int turn;
    NSMutableArray *players;
}

@property int numPlayers;
@property int numWerewolves;
@property BOOL hunter;
@property BOOL healer;
@property BOOL day;
@property int daysPassed;
@property int turn;
@property (retain) NSMutableArray *players;

+ (Game *) instance;

@end
