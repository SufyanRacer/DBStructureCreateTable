//
//  User.h
//  DBStructure
//
//  Created by Sufyan on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(atomic) int userId;
@property(atomic) NSString* name;
@property(atomic) NSString* panNumber;
@property(atomic) NSString* address;

-(instancetype)initWithID:(int)userId name:(NSString*)name panNumber:(NSString*)panNumber address:(NSString*)address;

-(instancetype)initWithName:(NSString *)name panNumber:(NSString *)panNumber address:(NSString *)address;
@end
