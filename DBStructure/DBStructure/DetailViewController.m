//
//  DetailViewController.m
//  DBStructure
//
//  Created by grepruby on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize users;
@synthesize usersList;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"All Users";
    users = [[DBManager getSharedInstance] fetchAllUsers];
    
}

-(void)fetchListAndReload{
    users = [[DBManager getSharedInstance] fetchAllUsers];
    [usersList reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [users count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserDetailsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailsCell"];
    
    if (cell) {
        User* user = (User*)[users objectAtIndex:indexPath.row];
        cell.name.text = user.name;
        cell.panNumber.text = user.panNumber;
        cell.address.text = user.address;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self deleteUser:[users objectAtIndex:indexPath.row]];
    
}

-(void)deleteUser:(User*)user{
    if ([[DBManager getSharedInstance] deleteRecordFromUserWithID:user.userId]) {
        [self fetchListAndReload];
    }
    else{
        [self fetchListAndReload];
    }
}

@end
