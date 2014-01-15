//
//  FightViewController.m
//  MCMS
//
//  Created by Andrew Webb on 1/15/14.
//  Copyright (c) 2014 Brad Shultz. All rights reserved.
//

#import "FightViewController.h"
#import "ViewController.h"

@interface FightViewController ()
{
    __weak IBOutlet UILabel *playerLabel;
    int round;
    __weak IBOutlet UILabel *roundLabel;
    __weak IBOutlet UILabel *opponentPowerLabel;
    __weak IBOutlet UILabel *playerPowerLabel;
    __weak IBOutlet UIImageView *opponentImageView;
    __weak IBOutlet UIButton *fightButton;
    __weak IBOutlet UIImageView *playerImageView;
    __weak IBOutlet UILabel *opponentLabel;
    BOOL alreadyOver;
}

@end

@implementation FightViewController
@synthesize player;
@synthesize opponent;
@synthesize opponentName;
@synthesize playerPower;
@synthesize opponentPower;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    roundLabel.text = @"Round 0";
    alreadyOver = NO;

    playerImageView.image = player.image;
    playerLabel.text = player.name;
    playerPowerLabel.text = [NSString stringWithFormat:@"Power Remaining: %i", playerPower];

    opponentImageView.image = opponent.image;
    opponentLabel.text = opponentName;
    opponentPowerLabel.text = [NSString stringWithFormat:@"Power Remaining: %i", opponentPower];
}
- (IBAction)onFightButtonPress:(id)sender
{
    if (alreadyOver) {
        [self newGame];
    }
    
    if (playerPower > 0 && opponentPower > 0)
    {
        int playerDamage = arc4random()%playerPower;
        int opponentDamage = arc4random()%opponentPower;
        
        playerPower -= opponentDamage;
        opponentPower -= playerDamage;
        
        playerPowerLabel.text = [NSString stringWithFormat:@"Power Remaining: %i", playerPower];
        opponentPowerLabel.text = [NSString stringWithFormat:@"Power Remaining: %i", opponentPower];
        roundLabel.text = [NSString stringWithFormat:@"Round %i",++round];
        [fightButton setTitle:@"Continue" forState:UIControlStateNormal];
    }
    if (playerPower > 0 && opponentPower <= 0)
        {
            [fightButton setTitle:@"You Win!" forState:UIControlStateNormal];
            alreadyOver = YES;
        }
    if (playerPower <= 0 && opponentPower > 0)
    {
        [fightButton setTitle:@"You Lose!" forState:UIControlStateNormal];
        alreadyOver = YES;
    }
    if (playerPower <= 0 && opponentPower <= 0)
    {
        [fightButton setTitle:@"Double KO!" forState:UIControlStateNormal];
        alreadyOver = YES;
    }

}

- (void)newGame
{
    ViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
