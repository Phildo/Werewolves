//
//  PlayerView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/10/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

@class PlayerView;

@protocol PlayerViewDelegate
    -(void)playerWasTouched:(PlayerView *)player;
@end

@interface PlayerView : UIImageView
{
    id <PlayerViewDelegate> delegate;
    int idNum;
    int type;
    int state;
    BOOL faded;
}

@property (assign) id <PlayerViewDelegate> delegate;
@property int idNum;
@property int type;
@property int state;
@property BOOL faded;

- (void)setAppearanceToType:(int)type state:(int)state faded:(BOOL)faded;
- (void)dim:(BOOL)dim;
- (void)incrementType;
- (void)iWasTouched;

@end
