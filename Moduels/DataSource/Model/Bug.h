//
//  Bug.h
//  bugTrack
//
//  Created by zhangyw on 14-12-25.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Bug : JSONModel
@property (nonatomic,assign) int      id;
@property (nonatomic,copy) NSString *project;
@property (nonatomic,copy) NSString *version;
@property (nonatomic,copy) NSString *distribter;
@property (nonatomic,copy) NSString *urgency;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *module;
@property (nonatomic,copy) NSString *platform;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *finish;
@end
