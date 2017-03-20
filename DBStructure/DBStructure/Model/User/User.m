//
//  User.m
//  DBStructure
//
//  Created by Sufyan on 07/03/17.
//  Copyright © 2017 Sufyan. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithName:(NSString *)name panNumber:(NSString *)panNumber address:(NSString *)address{
    if (!self) {
        self = [super init];
    }
    self.name = name;
    self.panNumber = panNumber;
    self.address = address;
    return self;
}

-(instancetype)initWithID:(int)userId name:(NSString*)name panNumber:(NSString*)panNumber address:(NSString*)address{
    if (!self) {
        self = [super init];
    }
    self.userId = userId;
    self.name = name;
    self.panNumber = panNumber;
    self.address = address;
    return self;
}

@end
