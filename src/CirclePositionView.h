//
//  CirclePositionView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "AppConstants.h"

@interface CirclePositionView : UIView
{
    id __unsafe_unretained delegate;
    int location;
    int count;
    int wolves;
    BOOL hunter;
    BOOL healer;
    
    CGPoint midPoint;
    CGFloat radius;
}

@property (assign) id delegate;
@property int location;
@property int count;
@property int wolves;
@property BOOL hunter;
@property BOOL healer;
@property CGPoint midPoint;
@property CGFloat radius;

- (void)setup;

@end
