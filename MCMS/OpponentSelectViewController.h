//
//  OpponentSelectViewController.h
//  MCMS
//
//  Created by Andrew Webb on 1/15/14.
//  Copyright (c) 2014 Brad Shultz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicalCreature.h"

@interface OpponentSelectViewController : UIViewController
@property NSArray* creatures;
@property MagicalCreature* playerCreature;
@property int playerPower;

@end
