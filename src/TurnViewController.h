//
//  TurnViewController.h
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "UIFViewController.h"

@class Game;

@protocol TurnViewControllerDelegate

@end
@interface TurnViewController : UIFViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<TurnViewControllerDelegate>)d game:(Game *)g;
@end
