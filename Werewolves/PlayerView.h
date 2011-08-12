//
//  PlayerView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/10/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerView : UIImageView
{
    id delegate;
}

@property (assign) id delegate;

- (void)setAppearanceToType:(int)type asleep:(BOOL)sleep faded:(BOOL)faded;
- (void)dim:(BOOL)dim;
- (void)incrementType;
@end
