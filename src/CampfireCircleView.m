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
    CGRect startBnd;
    
    id<CampfireCircleViewDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) NSMutableArray *playerViews;
@end

@implementation CampfireCircleView

@synthesize players;
@synthesize playerViews;

- (id) initWithFrame:(CGRect)frame delegate:(id<CampfireCircleViewDelegate>)d players:(NSArray *)p
{
    if(self = [super initWithFrame:frame])
    {
        self.playerViews = [[NSMutableArray alloc] initWithCapacity:30];
        [self updatePlayers:p];
        
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
    if(r.state == UIGestureRecognizerStateBegan) startPt = CGPointMake(self.center.x,self.center.y);
    
    CGPoint drag = [r translationInView:self];
    [self setCenter:CGPointMake(startPt.x+drag.x, startPt.y+drag.y)];
}

- (void) handlePinchGesture:(UIPinchGestureRecognizer *)r 
{
    if(r.state == UIGestureRecognizerStateBegan) startBnd = self.bounds;
    
    CGFloat factor = [(UIPinchGestureRecognizer *)r scale];
    CGFloat neww = startBnd.size.width*factor;  if(neww > 960) neww = 960;
    CGFloat newh = startBnd.size.height*factor; if(newh < 320) newh = 320;
        
    self.bounds = CGRectMake(startBnd.origin.x-((neww-startBnd.size.width)/2),startBnd.origin.y-((newh-startBnd.size.height)/2),neww,newh);
}

- (void) handleDoubleTapGesture:(UITapGestureRecognizer *)r
{
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
