//
//  ViewController.m
//  DBStructure
//
//  Created by Sufyan on 06/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "DetailViewController.h"
#import "DBOperations.h"

@interface ViewController ()
{
    NSArray* dbStructure;
}
@end

@implementation ViewController

@synthesize tableQueries;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DBOperations new] initializeDatabase];
}

- (IBAction)saveDataInDatabase:(id)sender {
    User* user = [[User alloc] initWithID:[self.idField.text intValue] name:self.nameField.text panNumber:self.panNumberField.text address:self.addressField.text];
    DBManager* manager = [DBManager getSharedInstance];
    [manager saveDataToUserTable:user];
    
    DetailViewController* detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}



@end
