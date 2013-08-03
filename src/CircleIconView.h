//
//  CircleIconView.h
//  werewolves
//
//  Created by Phil Dougherty on 8/3/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleIconView : UIView

- (void) setFrame:(CGRect)frame;
- (void) setCount:(int)newcount;
- (UIImage *) iconForPosition:(int)position;
- (void) refresh;

@end
