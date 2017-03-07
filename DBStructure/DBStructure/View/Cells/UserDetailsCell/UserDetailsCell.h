//
//  UserDetailCell.h
//  DBStructure
//
//  Created by grepruby on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *panNumber;
@property (weak, nonatomic) IBOutlet UILabel *address;
@end
