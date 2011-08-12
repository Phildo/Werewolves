//
//  PlayerView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/4/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "PlayerView.h"


@implementation PlayerView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)setAppearanceToType:(int)type asleep:(BOOL)sleep faded:(BOOL)faded
{
    
}

- (void)incrementType
{
    
}

- (void)dim:(BOOL)dim
{
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    [super dealloc];
}

@end
