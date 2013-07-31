//
//  WerewolvesRootViewcontroller.m
//  werewolves
//
//  Created by Phil Dougherty on 7/30/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "WerewolvesRootViewcontroller.h"
#import "IntroScreenViewController.h"

@interface WerewolvesRootViewcontroller ()

@end

@implementation WerewolvesRootViewcontroller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) loadView
{
    UINavigationController *n = [[UINavigationController alloc] init];
    IntroScreenViewController *isvc = [[IntroScreenViewController alloc] init];
    [n addChildViewController:isvc];
    self.view = n.view;
}

@end
