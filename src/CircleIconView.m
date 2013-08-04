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

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    radius = self.bounds.size.width/2;
    midPoint = CGPointMake(self.bounds.origin.x+radius, self.bounds.origin.y+radius);
}

- (void) setCount:(int)newCount
{
    count = newCount;
    [self refresh];
}

- (UIImage*) iconForPosition:(int)position
{
    return [UIImage imageNamed:@"dot.png"];
}

- (void) refresh
{
    for(UIView *icon in self.subviews) [icon removeFromSuperview];
    
    CGFloat angleIncrement = 2*M_PI/count;
    CGFloat tempRad = radius/2 + ((radius/2)*count/30);
    CGFloat iconSize = (tempRad/count)*6;
    CGPoint iconCenter;
    UIImageView *iconView;
    for(int i = 0; i < count; i++)
    {
        iconView = [[UIImageView alloc] initWithImage:[self iconForPosition:i]];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        iconCenter = CGPointMake(midPoint.x+tempRad*cos((i*angleIncrement)-(M_PI/2)), midPoint.y+tempRad*sin((i*angleIncrement)-(M_PI/2)));
        iconView.frame = CGRectMake(iconCenter.x-(iconSize/2), iconCenter.y-(iconSize/2), iconSize, iconSize);
        [self addSubview:iconView];
    }
}

@end
