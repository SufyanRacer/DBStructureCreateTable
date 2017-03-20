//
//  DBManager.h
//  DBStructure
//
//  Created by Sufyan on 07/03/17.
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
-(void)createTablesWith:(NSArray*)createTableQueries;
-(NSArray*)fetchAllUsers;
-(BOOL)updateRecordWithQuery:(NSString*)querySQL;

@end
