//
//  IntroScreenViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/5/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "IntroScreenViewController.h"

@interface IntroScreenViewController()
{
    id<IntroScreenViewControllerDelegate> __unsafe_unretained delegate;
}
@end

@implementation IntroScreenViewController

- (id) initWithDelegate:(id<IntroScreenViewControllerDelegate>)d
{
    if(self = [super initWithNibName:@"IntroScreenViewController" bundle:nil])
    {
        delegate = d;
    }
    return self;
}

- (IBAction) playButtonPressed
{
    [delegate introScreenRequestsGamePlay];
}

- (IBAction) instructionsButtonPressed
{
    NSLog(@"Nope");
}

@end
