//
//  PlayerView.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/4/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "PlayerView.h"
#import "Player.h"
#import "AppConstants.h"

@interface PlayerView()
{
    Player *player;
    BOOL faded;
    
    id <PlayerViewDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) Player *player;
@end

@implementation PlayerView

@synthesize player;

- (id)initWithFrame:(CGRect)frame player:(Player*)p delegate:(id<PlayerViewDelegate>)d
{
    if((self = [super initWithFrame:frame]))
    {
        player = p;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)]];
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTouch:)]];
    }
    return self;
}

- (void) updateView
{
    switch(player.type)
    {
        case C_VILLAGER:
            switch(player.state)
            {
                case C_AWAKE: [self setImage:[UIImage imageNamed:@"villager.png"]];       break;
                case C_SLEEP: [self setImage:[UIImage imageNamed:@"villager_sleep.png"]]; break;
                case C_DEAD:  [self setImage:[UIImage imageNamed:@"villager_dead.png"]];  break;
                default:      [self setImage:[UIImage imageNamed:@"img_not_found.png"]];  break;
            }
            break;
        case C_WEREWOLF:
            switch(player.state)
            {
                case C_AWAKE: [self setImage:[UIImage imageNamed:@"werewolf.png"]];       break;
                case C_SLEEP: [self setImage:[UIImage imageNamed:@"werewolf_sleep.png"]]; break;
                case C_DEAD:  [self setImage:[UIImage imageNamed:@"werewolf_dead.png"]];  break;
                default:      [self setImage:[UIImage imageNamed:@"img_not_found.png"]];  break;
            }
            break;
        case C_HUNTER:
            switch(player.state)
            {
                case C_AWAKE: [self setImage:[UIImage imageNamed:@"hunter.png"]];         break;
                case C_SLEEP: [self setImage:[UIImage imageNamed:@"hunter_sleep.png"]];   break;
                case C_DEAD:  [self setImage:[UIImage imageNamed:@"hunter_dead.png"]];    break;
                default:      [self setImage:[UIImage imageNamed:@"img_not_found.png"]];  break;
            }
        case C_HEALER:
            switch(player.state)
            {
                case C_AWAKE: [self setImage:[UIImage imageNamed:@"healer.png"]];         break;
                case C_SLEEP: [self setImage:[UIImage imageNamed:@"healer_sleep.png"]];   break;
                case C_DEAD:  [self setImage:[UIImage imageNamed:@"healer_dead.png"]];    break;
                default:      [self setImage:[UIImage imageNamed:@"img_not_found.png"]];  break;
            }
        default:
            [self setImage:[UIImage imageNamed:@"img_not_found.png"]];
            break;
    }
    
    if(faded) [self setAlpha:.5];
    else      [self setAlpha:1];
}

- (void) dim:(BOOL)dim
{
    faded = dim;
    [self updateView];
}

- (void) handleTouch:(UITapGestureRecognizer *)r
{
    [delegate player:self.player withView:self wasTouched:r];
}

- (void) handleLongTouch:(UILongPressGestureRecognizer *)r
{
    if(r.state == UIGestureRecognizerStateBegan)
        [delegate player:self.player withView:self wasLongTouched:r];
}

@end
