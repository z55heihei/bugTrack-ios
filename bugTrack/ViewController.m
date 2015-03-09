//
//  ViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-22.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "ViewController.h"
#import "DataGeterManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self getData];
}

-  (void)getData
{
//    [RE_SINGLETON(DataGeterManager) getUsersDataCompleteBlock:^(NSMutableArray *returnArray) {
//        NSLog(@"13->%@",returnArray);
//    } errorBlock:^(NSError *error) {
//        
//    }];

//    [RE_SINGLETON(DataGeterManager) postUserRegisterWithName:@"12w2s"
//                                                    password:@"124sdc5"
//                                                       email:@"122@11.com"
//                                                        team:@"1"
//                                               completeBlock:^{
//                                                   
//                                               } errorBlock:^(NSError *error){
//                                                   
//                                               }];

//    [RE_SINGLETON(DataGeterManager) postUserLoginWithName:@"z55heihei"
//                                                 password:@"123456"
//                                            completeBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) postUserModifyWithName:@"z55heihei"
//                                                  password:@"123456"
//                                                     email:@"8989892@qq.com"
//                                                     nName:@"yuyu"
//                                                 nPassword:@"123"
//                                                    nEmail:@"12@qq.com"
//                                             completeBlock:^{
//                                                 
//                                             } errorBlock:^(NSError *error) {
//                                                 
//                                             }];
    
//    [RE_SINGLETON(DataGeterManager) getBugsWithKey:@{@"urgency":@"1"}
//                                     completeBlock:^(NSMutableArray *returnArray) {
//                                         
//                                     } errorBlock:^(NSError *error) {
//                                         
//                                     }];
    
//    [RE_SINGLETON(DataGeterManager) postModuleCreatWith:@"录音"
//                                          completeBlock:^{
//                                              
//                                          } errorBlock:^(NSError *error) {
//                                              
//                                          }];
    
//    [RE_SINGLETON(DataGeterManager) getModulesCompleteBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager)postModulesDelete:@"1"
//                                       CompleteBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) getTeamsCompleteBlock:^(NSMutableArray *retuenArray){
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
//
    
//    [RE_SINGLETON(DataGeterManager) postTeamsDelete:@"1"
//                                      completeBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) getProjectsCompleteBlock:^(NSMutableArray *returnArray) {
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) postProjectsCreatWithProject:@"web后台开发"
//                                                         version:@"1.0"
//                                                   completeBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) postProjectDeleteWithProjectId:@"2"
//                                                     completeBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) getVersionsCompleteBlock:^(NSMutableArray *returnArray) {
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) postVersionDeleteWithVersionId:@"1" completeBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
//    [RE_SINGLETON(DataGeterManager) postVersionCreatWithVersion:@"1.35" completeBlock:^{
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
