//
//  PlayerSplitOverviewView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleIconView.h"

@interface PlayerSplitOverviewView : CircleIconView

- (void) setWerewolves:(int)w;
- (void) setHunter:(BOOL)h;
- (void) setHealer:(BOOL)h;

@end
