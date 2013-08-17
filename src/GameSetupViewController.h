//
//  GameSetupViewController.h
//  werewolves
//
//  Created by Phil Dougherty on 8/17/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "ContentViewController.h"

@class Game;

@protocol GameSetupViewControllerDelegate
- (void) gameSetupConfirmedWithGame:(Game *)g;
- (void) gameSetupAborted;
@end

@interface GameSetupViewController : ContentViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<GameSetupViewControllerDelegate>)d;
@end
