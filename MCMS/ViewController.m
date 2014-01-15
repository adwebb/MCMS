//
//  ViewController.m
//  MCMS
//
//  Created by Andrew Webb on 1/14/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "ViewController.h"
#import "MagicalCreature.h"
#import "CreatureViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *creatures;
    NSMutableArray *descriptions;
    __weak IBOutlet UITextField *magicalCreatureTextField;
    __weak IBOutlet UITableView *myTableView;
    
    __weak IBOutlet UIButton *addButton;
    
}

@end

@implementation ViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MagicalCreatureID"];
    MagicalCreature * cellMagicalCreature = creatures[indexPath.row];
    cell.textLabel.text = cellMagicalCreature.name;
    cell.detailTextLabel.text = cellMagicalCreature.description;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return creatures.count;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MagicalCreature * magicalCreature;
    creatures = [NSMutableArray array];
    
    NSArray* creatureNames = @[@"Unicorn", @"Centaur", @"Elf", @"Dwarf", @"Fairy", @"Dragon", @"Goblin", @"Centaur Don Bora", @"Hobbit Max Howell"];
    NSArray* creatureDescriptions = @[@"A horse-like creature with a single horn.",
                                    @"A fierce human/horse hybrid.",
                                    @"A dextrous humanoid with pointy ears.",
                                    @"A short and stout bearded warrior.",
                                    @"A small, winged, flying humanoid.",
                                    @"A fearsome, fire-breathing winged beast.",
                                    @"A fearsome if diminutive green-skinned humanoid.",
                                    @"A brilliant coder/teacher/half-stallion with impressive pectoral definition.",
                                    @"A small humanoid with a british accent. Enjoys long walks, never seen without his ring."];
    
    NSArray* creatureBasePowers = @[@6,@8,@8,@8,@2,@10,@4,@20,@20];
    
    NSArray* creatureImages = [[NSArray alloc] initWithObjects:
                               [UIImage imageNamed:@"unicorn.png"],
                               [UIImage imageNamed:@"centaur.png"],
                               [UIImage imageNamed:@"elf.png"],
                               [UIImage imageNamed:@"dwarf.png"],
                               [UIImage imageNamed:@"fairy.png"],
                               [UIImage imageNamed:@"dragon.png"],
                               [UIImage imageNamed:@"goblin.png"],
                               [UIImage imageNamed:@"centaurDon.png"],
                               [UIImage imageNamed:@"hobbitMax.png"], nil];
    
    for (int i = 0; i<creatureNames.count; i++)
    {
        magicalCreature = [MagicalCreature new];
        magicalCreature.name = creatureNames[i];
        magicalCreature.description = creatureDescriptions[i];
        magicalCreature.image = creatureImages[i];
        magicalCreature.power = creatureBasePowers[i];
        [creatures addObject:magicalCreature];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [myTableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addCreatureToTable];
    [textField resignFirstResponder];
    return YES;
}

-(void)addCreatureToTable
{
    MagicalCreature * magicalCreature;
    magicalCreature = [MagicalCreature new];
    magicalCreature.name = magicalCreatureTextField.text;
    magicalCreature.description = @"I'm honesly not sure what this is...";
    magicalCreature.image = [UIImage imageNamed:@"wolpertinger.png"];
    magicalCreature.power = @5;
    [creatures addObject:magicalCreature];
    [myTableView reloadData];
    [magicalCreatureTextField resignFirstResponder];
    magicalCreatureTextField.text = @"";
}

- (IBAction)onAddButtonPressed:(id)sender
{
    [self addCreatureToTable];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreatureViewController * cvc = segue.destinationViewController;
    NSIndexPath * indexPath = [myTableView indexPathForSelectedRow];
    cvc.creature = creatures[indexPath.row];
    cvc.creatures = [NSArray arrayWithArray:creatures];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
