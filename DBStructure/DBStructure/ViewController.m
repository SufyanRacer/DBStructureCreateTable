//
//  ViewController.m
//  DBStructure
//
//  Created by Sufyan on 06/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray* dbStructure;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* fileLocation = @"DBStructure.json";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSError* error = nil;
    dbStructure = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [self createTableQueries];
    
}

-(void)createTableQueries {
    NSString* tableName;
    NSDictionary* attributesDictionary;
    for (NSDictionary* object in dbStructure) {
        tableName = [self getTableNameFromDictionary:object];
        attributesDictionary = [object valueForKey:tableName];
        NSString* string = [self makeTableWithName:tableName andAttributesWithDictionary:attributesDictionary];
        // Execute query...
    }
}

-(NSString*)getTableNameFromDictionary:(NSDictionary*)dict {
    return [[dict allKeys] objectAtIndex:0];
}


-(NSString*)makeTableWithName:(NSString*)tableName andAttributesWithDictionary:(NSDictionary*)dict{
    
    NSMutableString* queryString = [[NSMutableString alloc] initWithString:@""];
    NSArray* allSortedKeys = [dict allKeys];

    for (int i=0; i<allSortedKeys.count; i++) {
        NSString* value = [dict objectForKey:[allSortedKeys objectAtIndex:i]];
        if ([[value lowercaseString] containsString:@"primary key"]) {
            queryString = [NSMutableString stringWithFormat:@"%@ %@, %@",[allSortedKeys objectAtIndex:i],[dict objectForKey:[allSortedKeys objectAtIndex:i]],queryString];
        } else{
            NSMutableString* attribString = [NSMutableString stringWithFormat:@"%@ %@",[allSortedKeys objectAtIndex:i],[dict objectForKey:[allSortedKeys objectAtIndex:i]]];
            [queryString appendString:attribString];
            if (allSortedKeys.count-1 == i) {
                [queryString appendString:@""];
            }else{
                [queryString appendString:@","];
            }
        }
    }
    queryString = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (%@)", tableName, queryString];
    [queryString replaceOccurrencesOfString:@",)"
                              withString:@")"
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, queryString.length)];
    NSLog(@"Query for creating table %@ : %@",tableName, queryString);
    return queryString;
}

@end
