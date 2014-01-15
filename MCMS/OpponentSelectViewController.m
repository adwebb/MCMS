//
//  OpponentSelectViewController.m
//  MCMS
//
//  Created by Andrew Webb on 1/15/14.
//  Copyright (c) 2014 Brad Shultz. All rights reserved.
//

#import "OpponentSelectViewController.h"
#import "FightViewController.h"

@interface OpponentSelectViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray* epithets;
    MagicalCreature* opponent;
    int opponentPowerLevel;
    NSString* opponentName;
}
@end

@implementation OpponentSelectViewController
@synthesize creatures;
@synthesize playerCreature;
@synthesize playerPower;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    epithets = @[@"Evil ",
                 @"Dastardly ",
                 @"Mega ",
                 @"Fallen ",
                 @"Undead ",
                 @"Un-",
                 @"Sadistic ",
                 @"Fel ",
                 @"Skeletal ",
                 @"Ghastly ",
                 @"Insane ",
                 @"Anti-",
                 @"Abyssal ",
                 @"Infernal ",
                 @"Crazed ",
                 @"Bloody "];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OpponentID"];
    int epithet = arc4random()%epithets.count;
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@",epithets[epithet],[creatures[indexPath.row] name]];
    cell.detailTextLabel.text = [creatures[indexPath.row] description];
    return cell;
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    opponent = creatures[indexPath.row];
    opponentPowerLevel = arc4random()%epithets.count*2 + opponent.power.intValue;
    opponentName = cell.textLabel.text;
    return indexPath;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return creatures.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FightViewController* fvc = segue.destinationViewController;
    fvc.player = playerCreature;
    fvc.opponent = opponent;
    fvc.playerPower = playerPower;
    fvc.opponentPower = opponentPowerLevel;
    fvc.opponentName = opponentName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
