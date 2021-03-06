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
    int state;
    NSMutableArray *players;
    NSMutableArray *history;
}

@property (nonatomic, assign) int numPlayers;
@property (nonatomic, readonly) int maxWerewolves;
@property (nonatomic, assign) int numWerewolves;
@property (nonatomic, assign) BOOL hunter;
@property (nonatomic, assign) BOOL healer;

@property (nonatomic, assign) int state;
@property (nonatomic, readonly) int nextState;

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSMutableArray *history;

@end
