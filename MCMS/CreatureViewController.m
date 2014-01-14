//
//  CreatureViewController.m
//  MCMS
//
//  Created by Brad Shultz on 1/14/14.
//  Copyright (c) 2014 Brad Shultz. All rights reserved.
//

#import "CreatureViewController.h"

@interface CreatureViewController ()
{
    
    __weak IBOutlet UILabel *name;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UIButton *editButton;
    __weak IBOutlet UIButton *saveButton;
}
@end


@implementation CreatureViewController

@synthesize creature;


- (void)viewDidLoad
{
    [super viewDidLoad];
    nameTextField.alpha = 0;
    name.text = creature.name;
    saveButton.alpha = 0;

}

- (IBAction)onEditButtonPressed:(id)sender {
    nameTextField.alpha = 1;
    name.alpha = 0;
    nameLabel.alpha = 0;
    editButton.alpha = 0;
    saveButton.alpha = 1;
    
    nameTextField.text = creature.name;
    
}

- (IBAction)onSaveButtonPressed:(id)sender {
    saveButton.alpha = 0;
    nameTextField.alpha = 0;
    nameLabel.alpha = 1;
    editButton.alpha = 1;
    name.alpha = 1;
    
    creature.name = nameTextField.text;
    name.text = creature.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
