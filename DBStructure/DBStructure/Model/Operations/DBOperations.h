//
//  DBOperations.h
//  DBStructure
//
//  Created by Sufyan on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "User.h"
@interface DBOperations : NSObject

@property (atomic) NSMutableArray* tableQueries;

-(void)initializeDatabase;

-(void)saveUserData:(User*)user;
-(BOOL)updateRecordWithUser:(User*)user;
-(BOOL)deleteRecordWithUserID:(int)userID;
@end
