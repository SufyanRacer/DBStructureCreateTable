//
//  DBManager.h
//  DBStructure
//
//  Created by grepruby on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "User.h"

@interface DBManager : NSObject
{
    NSString *databasePath;
}



+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)createTablesWith:(NSArray*)createTableQueries;
-(BOOL)saveDataToUserTable:(User*)user;
-(NSArray*)fetchAllUsers;
-(BOOL)deleteRecordFromUserWithID:(int)userID;
@end
