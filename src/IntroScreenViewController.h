//
//  IntroScreenViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/5/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFViewController.h"

@protocol IntroScreenViewControllerDelegate
- (void) introScreenRequestsGamePlay;
@end
@interface IntroScreenViewController : UIFViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<IntroScreenViewControllerDelegate>)d;
@end
