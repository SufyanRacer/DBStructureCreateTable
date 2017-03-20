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
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"saveUser"]) {
        return [self checkAllFields];
    } else {
        return true;
    }
}

- (BOOL)checkAllFields {
    if ([self.nameField.text isEqualToString:@""] || [self.panNumberField.text isEqualToString:@""] || [self.addressField.text isEqualToString:@""]) {
        [self showEmptyFieldsAlert];
        return false;
    } else {
        [self saveDataToDatabase];
        return true;
    }
}

-(void)saveDataToDatabase {
    User* user = [[User alloc] initWithName:self.nameField.text panNumber:self.panNumberField.text address:self.addressField.text];
    [[DBOperations new] saveUserData:user];
}

- (void)showEmptyFieldsAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter all fields." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
