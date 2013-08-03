//
//  CampfireCircleView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleIconView.h"

@protocol CampfireCircleViewDelegate
- (void) personWasTouched:(int)person;
@end

@interface CampfireCircleView : CircleIconView

@end