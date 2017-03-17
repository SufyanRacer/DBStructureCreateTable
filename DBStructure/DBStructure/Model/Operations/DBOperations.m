//
//  DBOperations.m
//  DBStructure
//
//  Created by grepruby on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "DBOperations.h"

@implementation DBOperations
{
    NSArray* dbStructure;
}
@synthesize tableQueries;

-(void)initializeDatabase{
    tableQueries = [[NSMutableArray alloc]init];
    [self readDBStructure];
    [self createTableQueries];
    [self makeDatabaseWithQueries];
}


-(void)readDBStructure{
    
    NSString* fileName = @"DBStructure.json";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSError* error = nil;
    dbStructure = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

-(void)createTableQueries {
    NSString* tableName;
    NSArray* attributesList;
    for (NSDictionary* object in dbStructure) {
        tableName = [self getFirstKeyNameFromDictionary:object];
        attributesList = [object valueForKey:tableName];
        NSString* query = [self makeTableQueryWithName:tableName andAttributesWithDictionary:attributesList];
        [tableQueries addObject:query];
    }
}

-(NSString*)getFirstKeyNameFromDictionary:(NSDictionary*)dict {
    return [[dict allKeys] objectAtIndex:0];
}

-(NSString*)makeTableQueryWithName:(NSString*)tableName andAttributesWithDictionary:(NSArray*)attributesList{
    
    NSMutableString* queryString = [[NSMutableString alloc] initWithString:@""];
    
    for (int i=0; i<attributesList.count; i++) {
        NSDictionary* attrib = [attributesList objectAtIndex:i];
        NSString* attribName = [self getFirstKeyNameFromDictionary:attrib];
        NSString* value = [attrib objectForKey:attribName];
        [queryString appendString:[NSString stringWithFormat:@"%@ %@,",attribName, value]];
    }
    queryString = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (%@)", tableName, queryString];
    [queryString replaceOccurrencesOfString:@",)"
                                 withString:@")"
                                    options:NSLiteralSearch
                                      range:NSMakeRange(0, queryString.length)];
    NSLog(@"Query for creating table %@ : %@",tableName, queryString);
    return queryString;
}

-(void)makeDatabaseWithQueries{
    DBManager* manager = [DBManager getSharedInstance];
    [manager createTablesWith:tableQueries];
}


- (BOOL)updateRecordWithUser:(User*)user{
    
    NSString* query = [NSString stringWithFormat:@"UPDATE peopleInfo SET Name='%@', PANNumber='%@', Address='%@' where Id=%d", user.name, user.panNumber, user.address, user.userId];
    DBManager* manager = [DBManager getSharedInstance];
    return [manager updateRecordWithQuery:query];
}


@end
