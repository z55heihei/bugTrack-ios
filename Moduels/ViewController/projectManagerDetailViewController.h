//
//  projectManagerDetailViewController.h
//  bugTrack
//
//  Created by zhangyw on 14-12-29.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface projectManagerDetailViewController : UITableViewController

@property (nonatomic,strong) Team *team;
@property (nonatomic,strong) Project *project;
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) Modules *module;
@property (nonatomic,strong) Version *version;

@end
