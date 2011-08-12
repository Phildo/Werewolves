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
    
    int DOT;
    int PLAYER;
}

@property (readonly) int MAX_NUM_PLAYERS;

@property (readonly) int VILLAGER;
@property (readonly) int WEREWOLF;
@property (readonly) int HUNTER;
@property (readonly) int HEALER;

@property (readonly) int DOT;
@property (readonly) int PLAYER;

+ (AppConstants *) instance;

@end
