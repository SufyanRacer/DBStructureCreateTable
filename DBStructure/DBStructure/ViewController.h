//
//  ViewController.h
//  DBStructure
//
//  Created by Sufyan on 06/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *panNumberField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

@property (atomic) NSMutableArray* tableQueries;

@end

