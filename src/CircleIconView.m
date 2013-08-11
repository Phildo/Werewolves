//
//  CircleIconView.m
//  werewolves
//
//  Created by Phil Dougherty on 8/3/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "CircleIconView.h"

@interface CircleIconView()
{
    int count;
    CGPoint midPoint;
    CGFloat radius;
}
@end

@implementation CircleIconView

- (id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setFrame:frame];
    }
    return self;
}

- (void) setFrame:(CGRect)f
{
    [super setFrame:f];
    radius = self.bounds.size.width/2;
    midPoint = CGPointMake(self.bounds.origin.x+radius, self.bounds.origin.y+radius);
}

- (void) setCount:(int)c
{
    count = c;
    [self refresh];
}

- (UIView *) viewForPosition:(int)p
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dot.png"]];
}

- (float) scaleForPosition:(int)p
{
    return 1.0;
}

- (void) refresh
{
    for(UIView *icon in self.subviews) [icon removeFromSuperview];
    
    CGFloat angleIncrement = 2*M_PI/count;
    CGFloat tempRad = radius/2 + ((radius/2)*count/30);
    CGFloat iconSize = (tempRad/count)*6;
    CGFloat iconSizeScale;
    CGPoint iconCenter;
    UIView *iconView;
    for(int i = 0; i < count; i++)
    {
        iconView = [self viewForPosition:i];
        iconSizeScale = [self scaleForPosition:i];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        iconCenter = CGPointMake(midPoint.x+tempRad*cos((i*angleIncrement)-(M_PI/2)), midPoint.y+tempRad*sin((i*angleIncrement)-(M_PI/2)));
        iconView.frame = CGRectMake(iconCenter.x-(iconSize*iconSizeScale/2), iconCenter.y-(iconSize*iconSizeScale/2), iconSize*iconSizeScale, iconSize*iconSizeScale);
        [self addSubview:iconView];
    }
}

@end
