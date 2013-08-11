//
//  TypePickerViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/21/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "TypePickerViewController.h"
#import "AppConstants.h"
#import "Game.h"
#import "Player.h"
#import "CampfireCircleView.h"
 
@interface TypePickerViewController() <CampfireCircleViewDelegate>
{
    UILabel *titleLabel;
    UILabel *numLeftLabel;
    UIButton *doneButton;
    CampfireCircleView *campFireCircle;
    int numLeft;
    int scene; //0- WerewolfPicker; 1- HunterPicker; 2- HealerPicker;
    
    Game *game;
    
    id<TypePickerViewControllerDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numLeftLabel;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) CampfireCircleView *campFireCircle;
@property (nonatomic, assign) int numLeft;
@property (nonatomic, assign) int scene;
@property (nonatomic, strong) Game *game;

@end
 
@implementation TypePickerViewController

@synthesize titleLabel;
@synthesize numLeftLabel;
@synthesize doneButton;
@synthesize campFireCircle;
@synthesize numLeft;
@synthesize scene;
@synthesize game;

- (id) initWithViewFrame:(CGRect)f delegate:(id<TypePickerViewControllerDelegate>)d game:(Game *)g
{
    if(self = [super initWithViewFrame:f])
    {
        self.game = g;
        
        delegate = d;
    }
    return self;
} 

- (void) loadView
{
    [super loadView];
    self.campFireCircle = [[CampfireCircleView alloc] initWithFrame:self.view.bounds delegate:self players:self.game.players];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIPinchGestureRecognizer *pinchZoom = [[UIPinchGestureRecognizer alloc] initWithTarget:self.campFireCircle action:@selector(handlePinchGesture:)];
    [self.campFireCircle addGestureRecognizer:pinchZoom];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.campFireCircle action:@selector(handlePanGesture:)];
    [self.campFireCircle addGestureRecognizer:pan];
    
    [self setScene:C_WEREWOLF_PICKER];
}

- (void) setScene:(int)s
{
    scene = s;
    switch(s)
    {
        case C_WEREWOLF_PICKER:
            self.titleLabel.text = @"Pick Your Werewolves";
            self.numLeft = self.game.numWerewolves;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.doneButton.hidden = YES;
            break;
        case C_HUNTER_PICKER:
            break;
        case C_HEALER_PICKER:
            break;
        default:
            break;
    }
}

- (void) backButtonPressed
{
    if(self.scene == C_WEREWOLF_PICKER)
    {
        for(int x = 0; x < self.game.numPlayers; x++)
        {
            ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(self.scene == C_HUNTER_PICKER)
    {
        for(int x = 0; x < self.game.numPlayers; x++)
        {
            if(((Player *)[self.game.players objectAtIndex:x]).type == C_HUNTER) 
            {
                ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
            }
        }
        self.titleLabel.text = @"Pick your Werewolves";
        self.numLeft = 0;
        self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
        self.doneButton.hidden = NO;
        self.scene = C_WEREWOLF_PICKER;
    }
    else if(self.scene == C_HEALER_PICKER)
    {
        for(int x = 0; x < self.game.numPlayers; x++)
        {
            if(((Player *)[self.game.players objectAtIndex:x]).type == C_HEALER) 
            {
                ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
            }
        }
        if(self.game.hunter)
        {
            self.titleLabel.text = @"Pick your Werewolves";
            self.numLeft = 0;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.doneButton.hidden = NO;
            self.scene = C_HUNTER_PICKER;
        }
        else
        {
            self.titleLabel.text = @"Pick your Hunter";
            self.numLeft = 0;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.doneButton.hidden = NO;
            self.scene = C_WEREWOLF_PICKER;
        }
    }
}

/*
- (void)diceButtonPressed
{
    int prob;
    int tempPlayersLeft;
    
    if(self.scene == C_WEREWOLF_PICKER)
    {
        self.numLeft = self.game.numWerewolves;
        tempPlayersLeft = self.game.numPlayers;
        
        for(int x = 0; x < self.game.numPlayers; x++)
        {
            prob = rand() % tempPlayersLeft;
            if(prob < self.numLeft)
            {
                ((Player *)[self.game.players objectAtIndex:x]).type = C_WEREWOLF;
                self.numLeft--;
            }
            else
            {
                ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
                [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
            }
            tempPlayersLeft--;
        }
    }
    else if(self.scene == C_HUNTER_PICKER)
    {
        self.numLeft = 1;
        tempPlayersLeft = self.game.numPlayers - self.game.numWerewolves;
        
        for(int x = 0; x < self.game.numPlayers; x++)
        {
            if(((Player *)[self.game.players objectAtIndex:x]).type != C_WEREWOLF)
            {
                prob = rand() % tempPlayersLeft;
                if(prob < self.numLeft)
                {
                    ((Player *)[self.game.players objectAtIndex:x]).type = C_HUNTER;
                    ((Player *)[self.game.players objectAtIndex:x]).show = C_HUNTER;
                    [self.campFireCircle turnPerson:x into:C_HUNTER animated:NO];
                    self.numLeft--;
                }
                else
                {
                    ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
                    ((Player *)[self.game.players objectAtIndex:x]).show = C_VILLAGER;
                    [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
                }
                tempPlayersLeft--;
            }
        }
    }
    else if(self.scene == C_HEALER_PICKER)
    {
        self.numLeft = 1;
        tempPlayersLeft = self.game.numPlayers - self.game.numWerewolves;
        if(self.game.hunter) tempPlayersLeft--;
        
        for(int x = 0; x < self.game.numPlayers; x++)
        {
            if(((Player *)[self.game.players objectAtIndex:x]).type != C_WEREWOLF && ((Player *)[self.game.players objectAtIndex:x]).type != C_HUNTER)
            {
                prob = rand() % tempPlayersLeft;
                if(prob < self.numLeft)
                {
                    ((Player *)[self.game.players objectAtIndex:x]).type = C_HEALER;
                    ((Player *)[self.game.players objectAtIndex:x]).show = C_HEALER;
                    [self.campFireCircle turnPerson:x into:C_HEALER animated:NO];
                    self.numLeft--;
                }
                else
                {
                    ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
                    ((Player *)[self.game.players objectAtIndex:x]).show = C_VILLAGER;
                    [self.campFireCircle turnPerson:x into:C_VILLAGER animated:NO];
                }
                tempPlayersLeft--;
            }
        }
    }
    
    self.numLeft = 0;
    self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
    self.doneButton.hidden = NO;
}
*/

- (void) doneButton
{
    if(self.scene == C_WEREWOLF_PICKER)
    {
        if(self.game.hunter)
        {
            self.titleLabel.text = @"Pick your Hunter";
            self.numLeft = 1;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.doneButton.hidden = YES;
            self.scene = C_HUNTER_PICKER;
        }
        else if(self.game.healer)
        {  
            self.titleLabel.text = @"Pick your Healer";
            self.numLeft = 1;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.doneButton.hidden = YES;
            self.scene = C_HEALER_PICKER;
        }
        else
        {
        }
    }
    else if(self.scene == C_HUNTER_PICKER)
    {
        if(self.game.healer)
        {
            self.titleLabel.text = @"Pick your Healer";
            self.numLeft = 1;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            self.doneButton.hidden = YES;
            self.scene = C_HEALER_PICKER;
        }
        else
        {
        }
        
    }
    else if(self.scene == C_HEALER_PICKER)
    {
    }
}

- (void) playerWasTouched:(Player *)p
{

}
- (void) player:(int)person WasTouchedWhilePicking:(int)type
{
    if(((Player *)[self.game.players objectAtIndex:person]).type == type)
    {
        self.numLeft++;
        self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
        ((Player *)[self.game.players objectAtIndex:person]).type = C_VILLAGER;
        self.doneButton.hidden = YES;
    }
    else if(((Player *)[self.game.players objectAtIndex:person]).type == C_VILLAGER)
    {
        if(self.numLeft > 0)
        {
            self.numLeft--;
            self.numLeftLabel.text = [NSString stringWithFormat:@"%d Left", self.numLeft];
            ((Player *)[self.game.players objectAtIndex:person]).type = type;
            if(self.numLeft == 0) self.doneButton.hidden = NO;
        }
    }
}

@end
