//
//  HistoryBrowserView.h
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryBrowserViewDelegate
@end

@interface HistoryBrowserView : UIView
- (id) initWithFrame:(CGRect)frame delegate:(id<HistoryBrowserViewDelegate>)d history:(NSMutableArray *)h;
- (void) updateHistory:(NSMutableArray *)h;
@end
