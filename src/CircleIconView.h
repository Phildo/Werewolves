//
//  CircleIconView.h
//  werewolves
//
//  Created by Phil Dougherty on 8/3/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleIconView : UIView
{
    CGFloat radius;
    CGPoint midPoint;
}

- (void) setCount:(int)c;
- (UIView *) viewForPosition:(int)p;
- (float) scaleForPosition:(int)p;
- (void) refresh;

@end
