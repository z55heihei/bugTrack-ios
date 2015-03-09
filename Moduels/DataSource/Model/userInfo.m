//
//  userInfo.m
//  bugTrack
//
//  Created by zhangyw on 14-12-27.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.team forKey:@"team"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self) {
        self.username = [decoder decodeObjectForKey:@"username"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.team = [decoder decodeObjectForKey:@"team"];
    }
    return self;
}

@end
