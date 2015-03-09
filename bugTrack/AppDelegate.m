//
//  AppDelegate.m
//  bugTrack
//
//  Created by zhangyw on 14-12-22.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

     _connectionState = eEMConnectionConnected;
    [[EaseMob sharedInstance] registerSDKWithAppKey:EASEMOB_KEY apnsCertName:@"bugtrack"];
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    //为消息监听方法注册监听器
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
    
    // 注册APNS类型
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    // 初始化
    [APService setupWithOption:launchOptions];
    
    userInfo *userInfos = (userInfo *)[RE_SINGLETON(DataUserManager) loadCustomObjectWithKey:@"userInfo"];
    NSString *userName = userInfos.username;
    if (!userName) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [self.window.rootViewController presentViewController:[storyBoard instantiateViewControllerWithIdentifier:@"LoginNavgationController"]
                                                         animated:YES
                                                       completion:nil];
        });
    }else{
        [APService setAlias:userName callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
    return YES;
}

+ (AppDelegate *)appDeleagte
{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

#pragma mark - IChatManagerDelegate

- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
}

#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if (!username) {
        return;
    }
    if (!message) {
        message = [NSString stringWithFormat:@"%@ 添加你为好友", username];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username,
                                                                               @"username":username,
                                                                               @"applyMessage":message,
                                                                               @"applyStyle":[NSNumber numberWithInteger:1]}];
    NSLog(@"%@",dic);
}


#pragma mark - EMChatManagerPushNotificationDelegate
- (void)didBindDeviceWithError:(EMError *)error
{
    if (error) {
        NSLog(@"消息推送与设备绑定失败");
    }
}

- (void)didReceiveRejectApplyToJoinGroupFrom:(NSString *)fromId
                                   groupname:(NSString *)groupname
                                      reason:(NSString *)reason
{
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", groupname];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"申请提示" message:reason delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
{
    NSString *tmpStr = group.groupSubject;
    NSString *str;
    if (!tmpStr || tmpStr.length == 0) {
        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup *obj in groupArray) {
            if ([obj.groupId isEqualToString:group.groupId]) {
                tmpStr = obj.groupSubject;
                break;
            }
        }
    }
    
    if (reason == eGroupLeaveReason_BeRemoved) {
        str = [NSString stringWithFormat:@"你被从群组\'%@\'中踢出", tmpStr];
    }
    if (str.length > 0) {
        NSLog(@"%@",str);
    }
}




#pragma mark - IChatManagerDelegate 群组变化

- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
{
    if (!groupId || !username) {
        return;
    }
    
    NSString *groupName = groupId;
    if (!message || message.length == 0) {
        message = [NSString stringWithFormat:@"%@ 邀请你加入群组\'%@\'", username, groupName];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupName,
                                                                               @"groupId":groupId,
                                                                               @"username":username,
                                                                               @"applyMessage":message,
                                                                               @"applyStyle":[NSNumber numberWithInteger:2]}];
    NSLog(@"%@",dic);
}


//接收到入群申请
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
    if (!groupId || !username) {
        return;
    }
    
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\'", username, groupname];
    }
    else{
        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\'：%@", username, groupname, reason];
    }
    
    if (error) {
        NSString *message = [NSString stringWithFormat:@"发送申请失败:%@\n原因：%@", reason, error.description];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupname,
                                                                                   @"groupId":groupId,
                                                                                   @"username":username,
                                                                                   @"groupname":groupname,
                                                                                   @"applyMessage":reason,
                                                                                   @"applyStyle":[NSNumber numberWithInteger:2]}];
        NSLog(@"%@",dic);
    }
}

#pragma mark ----处理apns接收消息（JPush SDK required）----

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 向服务器上报Device Token
    [APService registerDeviceToken:deviceToken];
    NSString* deviceTokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"%@",deviceTokenString);
    
     [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 处理收到的APNS消息，向服务器上报收到APNS消息
    NSLog(@"%@",userInfo);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bugReceiveRemote"
                                                        object:nil
                                                      userInfo:userInfo];
    
    [APService handleRemoteNotification:userInfo];
    
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
    NSString *tagsInString = [tags.allObjects componentsJoinedByString:@","];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateNow = [dateFormatter stringFromDate:[NSDate date]];
    NSString *labelText =nil;
    labelText = [NSString stringWithFormat:@"%@\n设置结果\n返回状态:%d\nTags:%@\nAlias:%@\n", dateNow, iResCode, tagsInString, alias];
    NSLog(@"%@",labelText);
}


#pragma mark ----JPush应用内消息回调方法（JPush SDK required）----
- (void)networkDidSetup:(NSNotification *)notification
{
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification
{
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification
{
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification
{
    NSLog(@"已登录");
}

//收到消息的回调方法，收到消息之后此方法会执行
- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
     [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
