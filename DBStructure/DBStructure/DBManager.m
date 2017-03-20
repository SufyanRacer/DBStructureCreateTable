//
//  DBManager.m
//  DBStructure
//
//  Created by Sufyan on 07/03/17.
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

-(NSString*)getDocumentDirectoryPath {
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    return docsDir;
    
}

-(void)setDatabasePath{
    NSString* docsDir = [self getDocumentDirectoryPath];
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

-(void)createTablesWith:(NSArray*)tableQueries{
    if ([tableQueries count]>= 1) {
        for (NSString* query in tableQueries) {
            if ( [self updateRecordWithQuery:query]) {
                NSLog(@"Table created with query : %@", query);
            } else {
                NSLog(@"Failed to create table with query : %@", query);
            }
        }
    }
}

-(NSArray*)fetchAllUsers{
    NSMutableArray* users = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *fetchSQL = @"SELECT * FROM User";
        const char *fetch_stmt = [fetchSQL UTF8String];
        
        if (sqlite3_prepare_v2(database, fetch_stmt,-1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int userID = sqlite3_column_int(statement, 0);
                char *nameChars = (char *) sqlite3_column_text(statement, 1);
                char *panNumberChars = (char *) sqlite3_column_text(statement, 2);
                char *addressChars = (char *) sqlite3_column_text(statement, 3);
                NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
                NSString *panNumber = [[NSString alloc] initWithUTF8String:panNumberChars];
                NSString *address = [[NSString alloc] initWithUTF8String:addressChars];
                User* user = [[User alloc] initWithID:userID name:name panNumber:panNumber address:address];
                [users addObject:user];
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    return users;
    
}

-(BOOL)updateRecordWithQuery:(NSString*)querySQL{
    
    BOOL isRecordUpdated = NO;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query_stmt = [querySQL UTF8String];
        sqlite3_prepare_v2(database, query_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Record updated");
            isRecordUpdated = YES;
        } else {
            NSLog(@"Failed to update record");
            isRecordUpdated = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return isRecordUpdated;
}

@end
