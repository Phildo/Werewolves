//
//  CampfireCircleView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "CampfireCircleView.h"


@implementation CampfireCircleView

@synthesize delegate;
@synthesize playerViews;
@synthesize midPoint;
@synthesize radius;
@synthesize initialBounds;
@synthesize initialPos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.playerViews = [[NSMutableArray alloc] initWithCapacity:[Game instance].numPlayers];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
    self.playerViews = [[NSMutableArray alloc] initWithCapacity:[Game instance].numPlayers];
}

- (void)setup
{
    self.radius = (self.bounds.size.width/2)*.8;
    CGPoint tempMid;
    tempMid.x = self.bounds.origin.x + self.bounds.size.width/2;
    tempMid.y = self.bounds.origin.y + self.bounds.size.height/2 + 20;
    self.midPoint = tempMid;
    
    [self.playerViews removeAllObjects];
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self setNeedsDisplay];
}

- (void)turnPerson:(int)location into:(int)type animated:(BOOL)animated
{
    [((PlayerView *)[self.playerViews objectAtIndex:location]) setAppearanceToType:type state:[AppConstants instance].AWAKE faded:NO];
}

- (void)playerWasTouched:(PlayerView *)player
{
    [delegate personWasTouched:player.idNum];
}
                                
- (void)drawRect:(CGRect)rect
{
    CGFloat angle = 0;
    CGFloat angleIncrement = 2*M_PI/[Game instance].numPlayers;
    CGPoint imageCenter;
    
    UIImageView *fire = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fire.png"]];
    fire.frame = CGRectMake(self.midPoint.x-self.bounds.size.width/6.4, self.midPoint.y-self.bounds.size.height/8.6, self.bounds.size.width/3.2, self.bounds.size.height/4.3);
    [self addSubview:fire];
    [fire release];
    
    for(int x = 0; x < [Game instance].numPlayers; x++)
    {
        imageCenter.x = (self.midPoint.x + self.radius*cos(angle-(M_PI/2)))-32;
        imageCenter.y = (self.midPoint.y + self.radius*sin(angle-(M_PI/2)))-48;
        PlayerView *player = [[PlayerView alloc] initWithFrame:CGRectMake(imageCenter.x, imageCenter.y, 64, 96)];
        player.delegate = self;
        player.idNum = x;
        player.tag = x;
        [player setAppearanceToType:((Player *)[[Game instance].players objectAtIndex:x]).type state:((Player *)[[Game instance].players objectAtIndex:x]).state faded:NO];
        UITapGestureRecognizer *tapPlayer = [[UITapGestureRecognizer alloc] initWithTarget:player action:@selector(iWasTouched)];
        [tapPlayer setNumberOfTapsRequired:1];
        [tapPlayer setNumberOfTouchesRequired:1];
        [player addGestureRecognizer:tapPlayer];
        [player setUserInteractionEnabled:YES];
        [self.playerViews addObject:player];
        [self addSubview:player];
        [tapPlayer release];
        [player release];
        angle+=angleIncrement;
    }
    
    for(int x = [Game instance].numPlayers; x > [Game instance].numPlayers/2; x--)
    {
        [self bringSubviewToFront:[self.subviews objectAtIndex:x]];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"zoop zop zoobity bop");
        self.initialPos = CGPointMake(sender.view.center.x,sender.view.center.y);
    }
    CGPoint vel = [sender translationInView:self];
    [self setCenter:CGPointMake(self.initialPos.x + vel.x, self.initialPos.y + vel.y)];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender 
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.initialBounds = self.bounds;
    }
    CGFloat factor = [(UIPinchGestureRecognizer *)sender scale];
    
    CGAffineTransform pz = CGAffineTransformScale(CGAffineTransformIdentity, factor, factor);
    self.bounds = CGRectApplyAffineTransform(initialBounds, pz);
    
    [self setup];
}

- (void)dealloc
{
    [playerViews release];
    [super dealloc];
}

@end
