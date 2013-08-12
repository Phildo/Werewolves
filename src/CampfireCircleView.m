//
//  CampfireCircleView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "CampfireCircleView.h"
#import "PlayerView.h"

@interface CampfireCircleView() <PlayerViewDelegate>
{
    NSArray *players;
    NSMutableArray *playerViews;
    
    //Hold state mid-gesture
    CGPoint startPt;
    CGFloat startScale;
    
    id<CampfireCircleViewDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) NSMutableArray *playerViews;
@end

@implementation CampfireCircleView

@synthesize players;
@synthesize playerViews;

- (id) initWithFrame:(CGRect)f delegate:(id<CampfireCircleViewDelegate>)d players:(NSArray *)p
{
    if(self = [super initWithFrame:f])
    {
        self.playerViews = [[NSMutableArray alloc] initWithCapacity:30];
        [self updatePlayers:p];
    
        [self addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)]];
        [self addGestureRecognizer:[[UIPanGestureRecognizer   alloc] initWithTarget:self action:@selector(handlePanGesture:)]];
        
        delegate = d;
    }
    return self;
}

- (void) updatePlayers:(NSArray *)p
{
    self.players = p;
    [self.playerViews removeAllObjects];
    for(int i = 0; i < [p count]; i++)
        [self.playerViews addObject:[[PlayerView alloc] initWithFrame:CGRectZero player:[self.players objectAtIndex:i] delegate:self]];
    [self setCount:[p count]];
}

- (UIView *) viewForPosition:(int)p
{
    return [self.playerViews objectAtIndex:p];
}

- (void) player:(Player *)p withView:(PlayerView *)pv wasTouched:(UITapGestureRecognizer *)r
{
    [delegate playerWasTouched:p];
}

- (void) player:(Player *)p withView:(PlayerView *)pv wasLongTouched:(UILongPressGestureRecognizer *)r
{
    
}

- (void) handlePanGesture:(UIPanGestureRecognizer *)r
{
    if(r.state == UIGestureRecognizerStateBegan) startPt = midPoint;
    
    CGPoint drag = [r translationInView:self];
    CGPoint newPt = CGPointMake(startPt.x+drag.x,startPt.y+drag.y);
    
    midPoint = newPt;
    [self constrainPos];
    [self refresh];
}

- (void) handlePinchGesture:(UIPinchGestureRecognizer *)r 
{
    if(r.state == UIGestureRecognizerStateBegan)
    {
        startPt = midPoint;
        startScale = radius;
    }
    
    CGFloat factor = [(UIPinchGestureRecognizer *)r scale];
    CGFloat newScale = startScale*factor;
    
    midPoint = CGPointMake((startPt.x-self.frame.size.width/2)*factor+self.frame.size.width/2, (startPt.y-self.frame.size.height/2)*factor+self.frame.size.height/2);
    radius = newScale;
    [self constrainPos];
    [self refresh];
}

- (void) constrainPos
{
    if(self.frame.size.width <= self.frame.size.height && radius < self.frame.size.width/2)  radius = self.frame.size.width/2;
    if(self.frame.size.height <= self.frame.size.width && radius < self.frame.size.height/2) radius = self.frame.size.height/2;
    if(self.frame.size.width <= self.frame.size.height && radius > self.frame.size.width)  radius = self.frame.size.width;
    if(self.frame.size.height <= self.frame.size.width && radius > self.frame.size.height) radius = self.frame.size.height;
    
    if(midPoint.x > self.frame.size.width+radius/4) midPoint.x = self.frame.size.width+radius/4;
    if(midPoint.x < 0-radius/4)                     midPoint.x = 0-radius/4;
    if(midPoint.y > self.frame.size.height+radius/4) midPoint.y = self.frame.size.height+radius/4;
    if(midPoint.y < 0-radius/4)                     midPoint.y = 0-radius/4;
}

- (void) handleDoubleTapGesture:(UITapGestureRecognizer *)r
{
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
