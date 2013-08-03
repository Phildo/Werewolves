//
//  IntroScreenViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/5/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroScreenViewControllerDelegate
- (void) introScreenRequestsGamePlay;
@end
@interface IntroScreenViewController : UIViewController
- (id) initWithDelegate:(id<IntroScreenViewControllerDelegate>)d;
@end
