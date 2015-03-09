//
//  userInfo.h
//  bugTrack
//
//  Created by zhangyw on 14-12-27.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userInfo : NSObject
@property (nonatomic,assign) int id;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *team;
@end
