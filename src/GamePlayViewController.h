//
//  GamePlayViewController.h
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "ContentViewController.h"

@class Game;

@protocol GamePlayViewControllerDelegate
- (void) gamePlayViewControllerAborted;
@end

@interface GamePlayViewController : ContentViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<GamePlayViewControllerDelegate>)d game:(Game *)g;
@end
