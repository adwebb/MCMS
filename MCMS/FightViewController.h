//
//  FightViewController.h
//  MCMS
//
//  Created by Andrew Webb on 1/15/14.
//  Copyright (c) 2014 Brad Shultz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicalCreature.h"

@interface FightViewController : UIViewController
@property MagicalCreature* player;
@property MagicalCreature* opponent;
@property NSString* opponentName;
@property int playerPower;
@property int opponentPower;
@end
