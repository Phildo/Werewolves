//
//  PlayerSetupViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/8/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFViewController.h"

@class Game;

@protocol PlayerSetupViewControllerDelegate
@end

@interface PlayerSetupViewController : UIFViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<PlayerSetupViewControllerDelegate>)d game:(Game *)g;
@end
