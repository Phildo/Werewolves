//
//  GameSetupViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;
@protocol GameSetupViewControllerDelegate
- (void) gameSetupConfirmedWithGame:(Game *)g;
- (void) gameSetupAborted;
@end

@interface GameSetupViewController : UIViewController
- (id)initWithDelegate:(id<GameSetupViewControllerDelegate>)d;
@end
