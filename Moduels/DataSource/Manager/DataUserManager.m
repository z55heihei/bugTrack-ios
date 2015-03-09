//
//  DataUserManager.m
//  bugTrack
//
//  Created by zhangyw on 14-12-27.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "DataUserManager.h"

@implementation DataUserManager

DEF_SINGLETON(DataUserManager)

- (void)saveValue:(id)value forKey:(NSString*)key
{
    NSUserDefaults*defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

- (id)getValueWithKey:(NSString*)key
{
    NSUserDefaults* deafaults = [NSUserDefaults standardUserDefaults];
    id value = [deafaults objectForKey:key];
    return value;
}

- (void)saveCutomObject:(NSObject *)obj objKey:(NSString *)key
{
    NSData *myEncoderObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncoderObject forKey:key];
}


- (NSObject *)loadCustomObjectWithKey:(NSString *)key
{
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    NSData *myEncoderObject = [defauts objectForKey:key];
    if (myEncoderObject) {
        NSObject *obj = [NSKeyedUnarchiver unarchiveObjectWithData:myEncoderObject];
        return obj;
    }
    return nil;
}

- (void)removeCustomObject:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
