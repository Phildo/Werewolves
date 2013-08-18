//
//  TypeSetupViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/21/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFViewController.h"

@class Game;

@protocol TypeSetupViewControllerDelegate
- (void) typeSetupDecidedWithGame:(Game *)g;
- (void) typeSetupAborted;
@end

@interface TypeSetupViewController : UIFViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<TypeSetupViewControllerDelegate>)d game:(Game *)g;
@end
