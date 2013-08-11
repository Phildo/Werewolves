//
//  PlayerView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/10/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayerView;
@class Player;

@protocol PlayerViewDelegate
- (void) player:(Player *)p withView:(PlayerView *)pv wasTouched:(UITapGestureRecognizer *)r;
- (void) player:(Player *)p withView:(PlayerView *)pv wasLongTouched:(UILongPressGestureRecognizer *)r;
@end

@interface PlayerView : UIImageView

- (id) initWithFrame:(CGRect)frame player:(Player*)p delegate:(id<PlayerViewDelegate>)d;
- (void) dim:(BOOL)dim;

@end
