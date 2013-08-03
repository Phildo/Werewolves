//
//  Player.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/3/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
{
    NSString *name;
    int type; //0-Villager; 1-Werewolf; 2-Hunter; 3-Healer;
    int state; //0-Awake; 1-Asleep; 2-Dead;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int state;

- (id) initWithName:(NSString *)n;
- (void) incrementType;
- (void) sleep;
- (void) wake;
- (void) kill;

@end
