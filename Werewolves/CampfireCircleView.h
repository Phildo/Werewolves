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

@class CampfireCircleView;

@protocol CampfireCircleViewDelegate
    - (void)personWasTouched:(int)person;
@end

@interface CampfireCircleView : UIView <PlayerViewDelegate>
{
    id <CampfireCircleViewDelegate> delegate;
        
    NSMutableArray *playerViews;
    
    CGPoint midPoint;
    CGFloat radius;
    CGRect initialBounds;
}

@property (assign) id <CampfireCircleViewDelegate> delegate;
@property (retain) NSMutableArray *playerViews;
@property CGPoint midPoint;
@property CGFloat radius;
@property CGRect initialBounds;

- (void)setup;
- (void)turnPerson:(int)location into:(int)type animated:(BOOL)animated;
- (void)playerWasTouched:(PlayerView *)player;
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender;
- (void)handlePanGesture:(UIPanGestureRecognizer *)sender;

@end