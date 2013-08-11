//
//  TypePickerViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/21/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFViewController.h"

@class Game;

@protocol TypePickerViewControllerDelegate
@end

@interface TypePickerViewController : UIFViewController
- (id) initWithViewFrame:(CGRect)f delegate:(id<TypePickerViewControllerDelegate>)d game:(Game *)g;
@end
