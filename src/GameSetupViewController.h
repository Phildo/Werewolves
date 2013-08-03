//
//  GameSetupViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameSetupViewControllerDelegate
@end

@interface GameSetupViewController : UIViewController
- (id)initWithDelegate:(id<GameSetupViewControllerDelegate>)d;
@end
