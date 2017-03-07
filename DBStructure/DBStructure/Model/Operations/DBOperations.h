//
//  DBOperations.h
//  DBStructure
//
//  Created by grepruby on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
@interface DBOperations : NSObject

@property (atomic) NSMutableArray* tableQueries;

-(void)initializeDatabase;

@end
