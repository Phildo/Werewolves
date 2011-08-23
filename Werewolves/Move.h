//
//  Move.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/23/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Move : NSObject {
    int action;
    int player;
}

@property int action;
@property int player;

@end
