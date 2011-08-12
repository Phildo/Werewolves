//
//  CirclePositionView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "CirclePositionView.h"


@implementation CirclePositionView

@synthesize delegate;
@synthesize location;
@synthesize radius;
@synthesize midPoint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.radius = self.bounds.size.width/2;
    CGPoint tempMid;
    tempMid.x = self.bounds.origin.x + self.radius;
    tempMid.y = self.bounds.origin.y + self.radius;
    self.midPoint = tempMid;
    [self setNeedsDisplay];
}

- (void)setCount:(int)newCount
{
    if(count != newCount)
    {
        count = newCount;
        [self setNeedsDisplay];
    }
    return;
}

- (int)count
{
    return count;
}

- (void)drawPositionForIcon:(int)type withMidPoint:(CGPoint)mid andSize:(float)size
{
    CGFloat width = size;
    CGFloat height = size;
    UIImageView *iconView;
    if(type == [AppConstants instance].PLAYER)
    {
        iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personIcon.png"]];
        height = size*1.3;
        width = size*0.8;
    }
    else if(type == [AppConstants instance].DOT)
    {
        iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
        height = size*0.7;
        width = size*0.7;
    }
    else
        iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notFound.png"]];
    iconView.frame = CGRectMake(mid.x-(size/2), mid.y-(size/2), width, height);
    [self addSubview:iconView];
    [iconView release];
}

- (void)drawRect:(CGRect)rect
{
    for (UIImageView *icon in self.subviews) 
        [icon removeFromSuperview];
    CGFloat angle = 0;
    CGFloat angleIncrement = 2*M_PI/self.count;
    CGPoint imageCenter;
    CGFloat tempRad = self.radius/2 + ((self.radius/2)*[Game instance].numPlayers/[AppConstants instance].MAX_NUM_PLAYERS);
    for(int i = 0; i < self.count; i++)
    {
        imageCenter.x = self.midPoint.x + tempRad*cos(angle-(M_PI/2));
        imageCenter.y = self.midPoint.y + tempRad*sin(angle-(M_PI/2));
        if(self.location == i || self.location == -1) 
            [self drawPositionForIcon:[AppConstants instance].PLAYER withMidPoint:imageCenter andSize:(tempRad/self.count)*4];
        else
            [self drawPositionForIcon:[AppConstants instance].DOT withMidPoint:imageCenter andSize:(tempRad/self.count)*4];
        angle+=angleIncrement;
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end