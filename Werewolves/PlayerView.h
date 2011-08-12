//
//  PlayerView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/10/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

@interface PlayerView : UIImageView
{
    id delegate;
    int type;
    int state;
    BOOL faded;
}

@property (assign) id delegate;
@property int type;
@property int state;
@property BOOL faded;

- (void)setAppearanceToType:(int)type state:(int)state faded:(BOOL)faded;
- (void)dim:(BOOL)dim;
- (void)incrementType;
@end
