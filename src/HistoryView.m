//
//  HistoryView.m
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "HistoryView.h"
#import "Move.h"
#import "Player.h"
#import "AppConstants.h"

@interface HistoryView()
{
    UIImageView *typeImage;
    UILabel *playerLabel;
    
    Move *move;
    
    id<HistoryViewDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, strong) UIImageView *typeImage;
@property (nonatomic, strong) UILabel *playerLabel;
@property (nonatomic, strong) Move *move;

@end

@implementation HistoryView

@synthesize typeImage;
@synthesize playerLabel;
@synthesize move;

- (id) initWithFrame:(CGRect)f move:(Move *)m delegate:(id<HistoryViewDelegate>)d
{
    if(self = [super initWithFrame:f])
    {
        self.move = m;
        
        self.typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,f.size.width,f.size.height-20)];
        [self addSubview:self.typeImage];
        self.playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,f.size.height-20,f.size.width,20)];
        [self addSubview:self.playerLabel];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iWasTouched:)]];
        
        [self refresh];
        delegate = d;
    }
    return self;
}

- (void) refresh
{
    switch(self.move.type)
    {
        case C_VILLAGER: [self.typeImage setImage:[UIImage imageNamed:@"villager.png"]]; break;
        case C_WEREWOLF: [self.typeImage setImage:[UIImage imageNamed:@"werewolf.png"]]; break;
        case C_HUNTER:   [self.typeImage setImage:[UIImage imageNamed:@"hunter.png"]];   break;
        case C_HEALER:   [self.typeImage setImage:[UIImage imageNamed:@"healer.png"]];   break;
        default:         [self.typeImage setImage:[UIImage imageNamed:@""]];             break;
    }
    if(self.move.player) self.playerLabel.text = self.move.player.name;
}

- (void) iWasTouched:(UITapGestureRecognizer *)r
{
    [delegate move:self.move withView:self wasTouched:r];
}

@end
