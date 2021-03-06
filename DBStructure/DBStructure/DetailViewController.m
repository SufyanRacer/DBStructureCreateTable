//
//  DetailViewController.m
//  DBStructure
//
//  Created by Sufyan on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "DetailViewController.h"
#import "EditUserDetailViewController.h"
#import "DBOperations.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize users;
@synthesize usersList;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"All Users";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self fetchListAndReload];
}

-(void)fetchListAndReload{
    dispatch_async(
       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           users = [[DBManager getSharedInstance] fetchAllUsers];
           dispatch_async(dispatch_get_main_queue(), ^{
               [usersList reloadData];
       });
    });
    
   
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [users count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserDetailsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailsCell"];
    
    if (cell) {
        User* user = (User*)[users objectAtIndex:indexPath.row];
        cell.userID.text = [NSString stringWithFormat:@"%d",user.userId];
        cell.name.text = user.name;
        cell.panNumber.text = user.panNumber;
        cell.address.text = user.address;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self deleteUser:[users objectAtIndex:indexPath.row]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"editUserDetails"]) {
        EditUserDetailViewController* editUserDetailViewController = (EditUserDetailViewController*) segue.destinationViewController;
        User* user = (User*) [users objectAtIndex:[usersList indexPathForSelectedRow].row];
        editUserDetailViewController.user = user;
    }
}

-(void)deleteUser:(User*)user{
    
    if ([[DBOperations new] deleteRecordWithUserID:user.userId]) {
        NSLog(@"record deleted");
    }
    else{
        NSLog(@"record not deleted");
    }
    [self fetchListAndReload];
}

@end
