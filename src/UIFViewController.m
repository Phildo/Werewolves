//
//  UIFViewController.m
//  werewolves
//
//  Created by Phil Dougherty on 8/10/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "UIFViewController.h"

@interface UIFViewController ()
{
    CGRect viewFrame;
}
@end

@implementation UIFViewController

- (id) initWithViewFrame:(CGRect)f
{
    if(self = [super init])
    {
        viewFrame = f;
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    self.view.frame = viewFrame;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.frame = viewFrame;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.frame = viewFrame;
}

@end
