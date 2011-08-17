//
//  CampfireCircleView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "Player.h"
#import "Game.h"
#import "PlayerView.h"


@interface CampfireCircleView : UIView {
    id delegate;
    
    NSMutableArray *playerViews;
    
    CGPoint midPoint;
    CGFloat radius;
}

@property (assign) id delegate;
@property (retain) NSMutableArray *playerViews;
@property CGPoint midPoint;
@property CGFloat radius;

- (void)setup;

@end
