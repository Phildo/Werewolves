//
//  AppConstants.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/3/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppConstants : NSObject {
    int MAX_NUM_PLAYERS;
    
    int VILLAGER;
    int WEREWOLF;
    int HUNTER;
    int HEALER;
    
    int AWAKE;
    int SLEEP;
    int DEAD;
    
    int DOT;
    int PLAYER_GREEN;
    int PLAYER_RED;
    int PLAYER_BROWN;
    int PLAYER_BLUE;
    
    int WEREWOLF_PICKER;
    int HUNTER_PICKER;
    int HEALER_PICKER;
}

@property (readonly) int MAX_NUM_PLAYERS;

@property (readonly) int VILLAGER;
@property (readonly) int WEREWOLF;
@property (readonly) int HUNTER;
@property (readonly) int HEALER;

@property (readonly) int AWAKE;
@property (readonly) int SLEEP;
@property (readonly) int DEAD;

@property (readonly) int DOT;
@property (readonly) int PLAYER_GREEN;
@property (readonly) int PLAYER_RED;
@property (readonly) int PLAYER_BROWN;
@property (readonly) int PLAYER_BLUE;

@property (readonly) int WEREWOLF_PICKER;
@property (readonly) int HUNTER_PICKER;
@property (readonly) int HEALER_PICKER;

+ (AppConstants *) instance;

@end
