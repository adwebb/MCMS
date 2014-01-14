//
//  ViewController.m
//  MCMS
//
//  Created by Brad Shultz on 1/14/14.
//  Copyright (c) 2014 Brad Shultz. All rights reserved.
//

#import "ViewController.h"
#import "MagicalCreature.h"
#import "CreatureViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *creatures;
    NSMutableArray *descriptions;
    __weak IBOutlet UITextField *magicalCreatureTextField;
    __weak IBOutlet UITableView *myTableView;
    
}

@end

@implementation ViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MagicalCreatureID"];
    MagicalCreature * cellMagicalCreature = creatures[indexPath.row];
    cell.textLabel.text = cellMagicalCreature.name;
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
    
    
    for (NSString * _name in @[@"unicorn", @"centaur", @"elf", @"dwarf", @"fairy", @"dragon", @"goblin"])
    {
        magicalCreature = [MagicalCreature new];
        magicalCreature.name = _name;
        [creatures addObject:magicalCreature];
    }
}

- (IBAction)onAddButtonPressed:(id)sender {
    MagicalCreature * magicalCreature;
    magicalCreature = [MagicalCreature new];
    magicalCreature.name = magicalCreatureTextField.text;
    [creatures addObject:magicalCreature];
    [myTableView reloadData];
    [magicalCreatureTextField resignFirstResponder];
    magicalCreatureTextField.text = @"";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreatureViewController * cvc = segue.destinationViewController;
    NSIndexPath * indexPath = [myTableView indexPathForSelectedRow];
    cvc.creature = creatures[indexPath.row];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
