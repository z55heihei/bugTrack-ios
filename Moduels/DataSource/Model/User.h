//
//  User.h
//  bugTrack
//
//  Created by zhangyw on 14-12-25.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : JSONModel
@property (nonatomic,assign) int      id;
@property (nonatomic,copy  ) NSString *username;
@property (nonatomic,copy  ) NSString *email;
@end
