//
//  AppDelegate.h
//  bugTrack
//
//  Created by zhangyw on 14-12-22.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate>
{
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)appDeleagte;
@end
