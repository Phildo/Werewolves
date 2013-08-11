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
    
    CGRect initialFrame;
    
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
        initialFrame = f;
        self.clipsToBounds = YES;
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
    if(r.state == UIGestureRecognizerStateBegan) startPt = CGPointMake(self.bounds.origin.x,self.bounds.origin.y);
    
    CGPoint drag = [r translationInView:self];
    self.bounds = CGRectMake(startPt.x-drag.x, startPt.y-drag.y, self.bounds.size.width, self.bounds.size.height);
    [self constrainBounds];
}

- (void) handlePinchGesture:(UIPinchGestureRecognizer *)r 
{
    if(r.state == UIGestureRecognizerStateBegan) startBnd = self.bounds;
    
    CGFloat factor = [(UIPinchGestureRecognizer *)r scale];
    CGFloat neww = startBnd.size.width*factor;
    CGFloat newh = startBnd.size.height*factor;
    if(initialFrame.size.height <= initialFrame.size.width && newh < initialFrame.size.height)
    {
        neww *= initialFrame.size.height/newh;
        newh *= initialFrame.size.height/newh;
    }
    if(initialFrame.size.width <= initialFrame.size.height && neww < initialFrame.size.width)
    {
        newh *= initialFrame.size.width/neww;
        neww *= initialFrame.size.width/neww;
    }
    
    self.bounds = CGRectMake(startBnd.origin.x-((neww-startBnd.size.width)/2),startBnd.origin.y-((newh-startBnd.size.height)/2),neww,newh);
    [self constrainBounds];
}

- (void) handleDoubleTapGesture:(UITapGestureRecognizer *)r
{
    self.bounds = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
}

- (void) constrainBounds
{
    
}

@end
