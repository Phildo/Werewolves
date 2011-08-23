//
//  GamePlayViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/22/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Player.h"
#import "Move.h"
#import "DayChangerView.h"
#import "CampfireCircleView.h"

@interface GamePlayViewController : UIViewController <CampfireCircleViewDelegate>
{
    int state; //0- Villagers' Turn; 1- Werewolves' Turn; 2- Hunter's Turn; 3- Healer's Turn; 
}

@end
