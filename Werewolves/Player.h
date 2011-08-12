//
//  Player.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/3/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"


@interface Player : NSObject {
    NSString *name;
    int playerId;
    int type; //0-Villager; 1-Werewolf; 2-Hunter; 3-Healer;

    int dayKilled;
    
    BOOL isAlive;
    BOOL isAwake;
}

@property (retain) NSString *name;
@property int playerId;
@property int type;
@property int dayKilled;
@property BOOL isAlive;
@property BOOL isAwake;

- (id) init;
- (void) dealloc;

@end
