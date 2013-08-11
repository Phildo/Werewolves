//
//  CampfireCircleView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleIconView.h"

@class Player;

@protocol CampfireCircleViewDelegate
- (void) playerWasTouched:(Player *)p;
- (void) player:(Player *)p wasReleasedBeforePosition:(int)pos;
@end

@interface CampfireCircleView : CircleIconView
- (id) initWithFrame:(CGRect)frame delegate:(id<CampfireCircleViewDelegate>)d players:(NSArray *)p;
- (void) updatePlayers:(NSArray *)p;
@end