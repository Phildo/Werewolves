//
//  Move.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/23/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@interface Move : NSObject
{
    Player *player;
    int type;
}

@property (nonatomic, strong) Player *player;
@property (nonatomic, assign) int type;

- (id) initWithType:(int)t player:(Player *)p;

@end
