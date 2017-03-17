//
//  EditUserDetailViewController.h
//  DBStructure
//
//  Created by grepruby on 17/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface EditUserDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *panNumberField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

@property(atomic)User* user;

@end
