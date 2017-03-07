//
//  DetailViewController.h
//  DBStructure
//
//  Created by grepruby on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "UserDetailsCell.h"
#import "User.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *usersList;

@property (atomic)NSArray* users;

@end
