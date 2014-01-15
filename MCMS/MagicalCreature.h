//
//  MagicalCreature.h
//  MCMS
//
//  Created by Andrew Webb on 1/14/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicalCreature : NSObject

@property NSString* name;
@property NSString* description;
@property UIImage* image;
@property NSMutableArray* accessories;
@property NSNumber* power;

@end
