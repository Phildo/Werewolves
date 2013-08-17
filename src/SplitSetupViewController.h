//
//  SplitSetupViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFViewController.h"

@protocol SplitSetupViewControllerDelegate
- (void) splitSetupDecided;
- (void) splitSetupAborted;
@end

@interface SplitSetupViewController : UIFViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<SplitSetupViewControllerDelegate>)d;
@end
