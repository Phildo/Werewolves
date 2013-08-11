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
    CGFloat radius;
}
@end

@implementation CircleIconView

- (id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void) setFrame:(CGRect)f
{
    [super setFrame:f];
    [self setBounds:CGRectMake(0, 0, f.size.width, f.size.height)];
}
    
- (void) setBounds:(CGRect)b
{
    if(b.size.height > b.size.width)
    {
        b.origin.y += (int)((b.size.height-b.size.width)/2);
        b.size.height = b.size.width;
    }
    if(b.size.width > b.size.height)
    {
        b.origin.x += (int)((b.size.width-b.size.height)/2);
        b.size.width = b.size.height;
    }
    [super setBounds:b];
    
    int newRadius = b.size.width/2;
    if(radius != newRadius)
    {
        radius = newRadius;
        [self refresh];
    }
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
        iconCenter = CGPointMake(radius+tempRad*cos((i*angleIncrement)-(M_PI/2)), radius+tempRad*sin((i*angleIncrement)-(M_PI/2)));
        iconView.frame = CGRectMake(iconCenter.x-(iconSize*iconSizeScale/2), iconCenter.y-(iconSize*iconSizeScale/2), iconSize*iconSizeScale, iconSize*iconSizeScale);
        [self addSubview:iconView];
    }
}

@end
