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

- (id) initWithViewFrame:(CGRect)f delegate:(id<IntroScreenViewControllerDelegate>)d
{
    if(self = [super initWithViewFrame:f])
    {
        delegate = d;
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 40);
    [playBtn setTitle:@"play" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    UIButton *instBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    instBtn.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2+10, 100, 40);
    [instBtn setTitle:@"instructions" forState:UIControlStateNormal];
    [instBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [instBtn addTarget:self action:@selector(instructionsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instBtn];
}

- (void) playButtonPressed
{
    [delegate introScreenRequestsGamePlay];
}

- (void) instructionsButtonPressed
{
    NSLog(@"Nope");
}

@end
