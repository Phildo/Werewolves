//
//  PlayerPositionView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "PlayerPositionView.h"

@interface PlayerPositionView()
{
    int position;
}
@end

@implementation PlayerPositionView

- (void) setPosition:(int)p
{
    position = p;
    [self refresh];
}

- (UIView *) viewForPosition:(int)p
{
    if(position == p) return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personIcon_green.png"]];
    else              return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
}

- (float) scaleForPosition:(int)p
{
    if(position == p) return 1.2;
    else              return 0.8;
}

@end
