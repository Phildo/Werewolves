//
//  CirclePositionView.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface CirclePositionView : UIView
{
    id delegate;
    int location;
    int count;
    
    CGPoint midPoint;
    CGFloat radius;
}

@property (assign) id delegate;
@property int location;
@property int count;
@property CGPoint midPoint;
@property CGFloat radius;

@end
