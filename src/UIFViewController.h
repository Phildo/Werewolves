//
//  UIFViewController.h
//  werewolves
//
//  Created by Phil Dougherty on 8/10/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

//Simple wrapper to easily take complete control of the frame of the view of your viewcontroller

#import <UIKit/UIKit.h>

@interface UIFViewController : UIViewController
- (id) initWithViewFrame:(CGRect)f;
@end
