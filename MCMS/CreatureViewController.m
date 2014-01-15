//
//  CreatureViewController.m
//  MCMS
//
//  Created by Andrew Webb on 1/14/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "CreatureViewController.h"
#import "OpponentSelectViewController.h"

@interface CreatureViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *accessoryTableView;
    __weak IBOutlet UILabel *name;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UIButton *editButton;
    __weak IBOutlet UIButton *saveButton;
    __weak IBOutlet UILabel *descriptionLabel;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *tableTitleLabel;
    __weak IBOutlet UILabel *inventoryLabel;
    NSMutableArray* accessories;
    NSArray* accessoryDescriptions;
    NSArray* accessoryPowerLevels;
    __weak IBOutlet UILabel *currentPower;
    int currentPlayerPowerLevel;
    __weak IBOutlet UIButton *fightButton;
}

@end


@implementation CreatureViewController

@synthesize creature;
@synthesize creatures;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentPlayerPowerLevel = creature.power.intValue;
    nameTextField.alpha = 0;
    saveButton.alpha = 0;
    accessoryTableView.alpha = 0;
    tableTitleLabel.alpha = 0;
    inventoryLabel.alpha = 0;
    name.text = creature.name;
    currentPower.text = [NSString stringWithFormat:@"Power Level: %i", creature.power.intValue];
    [currentPower sizeToFit];
    descriptionLabel.text = creature.description;
    [descriptionLabel sizeToFit];
    imageView.image = creature.image;
    
    accessories = @[@"Bracer of Strength",
                            @"Lightning Spear",
                            @"Boots of Water Walking",
                            @"Full Platemail",
                            @"Potion of Fire Resistance",
                            @"Cone of Cold",
                            @"Twin Strike",
                            @"Amulet of Health",
                            @"Brutal Axe of Slaying",
                            @"Helm of Battle",
                            @"Ring of Greater Speed",
                            @"Fire Breath",
                            @"Pants of Levitation",
                            @"Laser Vision",
                            @"Rusty Dagger",
                            @"A ring of keys",
                            @"Cloth Belt",
                            @"Iron Mallet"].mutableCopy;
    
    accessoryDescriptions = @[@"You feel stronger just looking at them.",
                                       @"Arcs of electricity run along the tip.",
                                       @"More cool than powerful, really.",
                                       @"A heavy, iron suit of armor.",
                                       @"Promises to absorb fire attacks.",
                                       @"A potent cold attack spell.",
                                       @"A powerful melee attack.",
                                       @"A mundane-looking amulet.",
                                       @"Dwarven Steel, complete with warrantee.",
                                       @"\"Don't face danger with your face.\"\u2122",
                                       @"Your heart races with anticipation.",
                                       @"Sure to confuse a Dragon!",
                                       @"Better than a floating mentor.",
                                       @"Is that like Cyclops, or Superman?",
                                       @"The tetanus is the most dangerous part.",
                                       @"Really?",
                                       @"Perfect for holding your pants up.",
                                       @"Ideal for Playing Whack-A-Monster\u2122"];
    
    accessoryPowerLevels = @[@5,@8,@2,@4,@5,@7,@3,@8,@6,@5,@8,@2,@4,@3,@1,@1,@4,@6];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoryID"];
    cell.textLabel.text = accessories[indexPath.row];
    cell.detailTextLabel.text = accessoryDescriptions[indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return accessories.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    int itemCount =[inventoryLabel.text substringToIndex:1].intValue;
    
    
        if (![cell.textLabel.text hasPrefix:@"\u2713"])
        {
            if (itemCount < 5)
            {
                inventoryLabel.text = [NSString stringWithFormat:@"%i / 5", ++itemCount];
                [creature.accessories addObject:accessories[indexPath.row]];
                accessories[indexPath.row] = [NSString stringWithFormat:@"\u2713 %@", cell.textLabel.text];
                currentPlayerPowerLevel += [accessoryPowerLevels[indexPath.row] intValue];
                [tableView reloadData];
                currentPower.text = [NSString stringWithFormat:@"Power Level: %i",currentPlayerPowerLevel];
            }
            
        } else {
            inventoryLabel.text = [NSString stringWithFormat:@"%i / 5", --itemCount];
            accessories[indexPath.row] = [cell.textLabel.text substringFromIndex:[@"\u2713 " length]];
            [creature.accessories removeObjectIdenticalTo:accessories[indexPath.row]];
            currentPlayerPowerLevel -= [accessoryPowerLevels[indexPath.row] intValue];
            [tableView reloadData];
            currentPower.text = [NSString stringWithFormat:@"Power Level: %i", currentPlayerPowerLevel];
        }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [nameTextField resignFirstResponder];
    return YES;
}

- (IBAction)onEditButtonPressed:(id)sender
{
    
    name.alpha = 0;
    nameLabel.alpha = 0;
    editButton.alpha = 0;
    currentPower.alpha = 0;
    fightButton.alpha = 0;
    
    saveButton.alpha = 1;
    nameTextField.alpha = 1;
    accessoryTableView.alpha = 1;
    tableTitleLabel.alpha = 1;
    inventoryLabel.alpha = 1;
    
    nameTextField.text = creature.name;
    
}

-(void)saveData
{
    saveButton.alpha = 0;
    nameTextField.alpha = 0;
    accessoryTableView.alpha = 0;
    tableTitleLabel.alpha = 0;
    inventoryLabel.alpha = 0;
    
    
    nameLabel.alpha = 1;
    editButton.alpha = 1;
    name.alpha = 1;
    currentPower.alpha = 1;
    fightButton.alpha = 1;
    
    [nameTextField resignFirstResponder];
    creature.name = nameTextField.text;
    name.text = creature.name;
}

- (IBAction)onSaveButtonPressed:(id)sender
{
    [self saveData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OpponentSelectViewController* osvc = segue.destinationViewController;
    osvc.creatures = creatures;
    osvc.playerCreature = creature;
    osvc.playerPower = currentPlayerPowerLevel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
