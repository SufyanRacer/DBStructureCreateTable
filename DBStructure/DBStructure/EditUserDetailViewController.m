//
//  EditUserDetailViewController.m
//  DBStructure
//
//  Created by grepruby on 17/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "EditUserDetailViewController.h"
#import "DBOperations.h"

@interface EditUserDetailViewController ()

@end

@implementation EditUserDetailViewController
@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Update Details";
    [self setDataToFields];
}

- (void)setDataToFields{
    self.nameField.text = user.name;
    self.panNumberField.text = user.panNumber;
    self.addressField.text = user.address;
}

- (IBAction)updateDataToDatabase:(id)sender {
    
    if ([self checkAllFields]) {
        [self updateRecord];
    } else {
        [self showEmptyFieldsAlert];
    }
    
}

- (BOOL)checkAllFields {
    if ([self.nameField.text isEqualToString:@""] || [self.panNumberField.text isEqualToString:@""] || [self.addressField.text isEqualToString:@""]) {
        return false;
    } else {
        return true;
    }
}


-(void)updateRecord{
    DBOperations* operations = [DBOperations new];
    BOOL isUpdated = [operations updateRecordWithUser:[[User alloc] initWithID:user.userId name:self.nameField.text panNumber:self.panNumberField.text address:self.addressField.text]];
    if (!isUpdated) {
        NSLog(@"Data is not updated due to some issue.");
    }
}

- (void)showEmptyFieldsAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter all fields." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
