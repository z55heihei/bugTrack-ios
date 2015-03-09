//
//  DataUserManager.h
//  bugTrack
//
//  Created by zhangyw on 14-12-27.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userInfo.h"

@interface DataUserManager : NSObject

AS_SINGLETON(DataUserManager)

- (id)getValueWithKey:(NSString*)key;
- (void)saveValue:(id)value forKey:(NSString*)key;
- (void)saveCutomObject:(NSObject *)obj objKey:(NSString *)key;
- (void)removeCustomObject:(NSString *)key;
- (NSObject *)loadCustomObjectWithKey:(NSString *)key;


@end
