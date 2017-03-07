//
//  DBManager.m
//  DBStructure
//
//  Created by grepruby on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance setDatabasePath];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(void)setDatabasePath{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"User_database.sqlite"]];
}

-(BOOL)createDB{
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            isSuccess = YES;
            sqlite3_close(database);
            return isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

-(BOOL)createTablesWith:(NSArray*)createTableQueries{
    if ([createTableQueries count]>= 1) {
        BOOL isSuccess = YES;
        
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
        
            for (NSString* query in createTableQueries) {
                char *errMsg;
                const char *sql_stmt =  [query UTF8String];
                if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
                {
                    isSuccess = NO;
                    NSLog(@"Failed to create table");
                }
            }
            sqlite3_close(database);
        }
        return isSuccess;
        
    } else {
        return NO;
    }
    
}

-(BOOL)saveDataToUserTable:(User*)user{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO User (Id,name, PANNumber,Address) VALUES(%d,'%@', '%@', '%@')",user.userId, user.name,user.panNumber,user.address];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
    }
    return NO;
}

-(NSArray*)fetchAllUsers{
    NSMutableArray* users = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = @"SELECT * FROM User";
        const char *insert_stmt = [insertSQL UTF8String];
        
        if (sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int userID = sqlite3_column_int(statement, 0);
                char *panNumberChars = (char *) sqlite3_column_text(statement, 1);
                char *addressChars = (char *) sqlite3_column_text(statement, 2);
                char *nameChars = (char *) sqlite3_column_text(statement, 3);
                NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
                NSString *panNumber = [[NSString alloc] initWithUTF8String:panNumberChars];
                NSString *address = [[NSString alloc] initWithUTF8String:addressChars];
                User* user = [[User alloc] initWithID:userID name:name panNumber:panNumber address:address];
                [users addObject:user];
            }
            sqlite3_finalize(statement);
        }
    }
    return users;
    
}

-(BOOL)deleteRecordFromUserWithID:(int)userID{
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"DELETE FROM User WHERE Id=%d",userID];
        const char *query_stmt = [querySQL UTF8String];
        sqlite3_prepare_v2(database, query_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"deleted record");
            return YES;
        } else {
            NSLog(@"Failed to delete record");
            return NO;
        }
    }
    return NO;
}



@end
