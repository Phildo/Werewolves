//
//  Game.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
{
    int numPlayers;
    int numWerewolves;
    BOOL hunter;
    BOOL healer;
    BOOL day;
    int daysPassed;
    int turnState;
    NSMutableArray *players;
    NSMutableArray *history;
}

@property int numPlayers;
- (int) maxWerewolves;
@property int numWerewolves;
@property BOOL hunter;
@property BOOL healer;
@property BOOL day;
@property int daysPassed;
@property int turnState;
@property (retain) NSMutableArray *players;
@property (retain) NSMutableArray *history;

@end
