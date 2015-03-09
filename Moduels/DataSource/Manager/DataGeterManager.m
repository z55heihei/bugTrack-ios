//
//  DataGeterManager.m
//  bugTrack
//
//  Created by zhangyw on 14-12-22.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "DataGeterManager.h"

@implementation DataGeterManager

DEF_SINGLETON(DataGeterManager)

- (void)getUsersDataCompleteBlock:(void (^)(NSMutableArray *returnArray))completeblock
                       errorBlock:(void (^)(NSError *error))errorblock
{
    [RE_SINGLETON(DataPosterManager) postData:nil
                                   httpMethod:GET
                                       server:SERVERURL(@"allUser")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSMutableArray *returnArray = [NSMutableArray array];
                                    NSArray *usersArray = returnDict[@"users"];
                                    [usersArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        NSDictionary *userDict = obj;
                                        User *user = [[User alloc] initWithDictionary:userDict error:NULL];
                                        [returnArray addObject:user];
                                    }];
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock(returnArray);
                                        }
                                    }
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postUserDeleteWithId:(NSString *)userId
               completeBlock:(void(^)(void))completeblock
                  errorBlock:(void(^)(NSError *error))errorblock
{
   NSMutableDictionary *userDeleteDict = [@{@"userId":userId}mutableCopy];
   [RE_SINGLETON(DataPosterManager) postData:userDeleteDict
                                  httpMethod:POST
                                      server:SERVERURL(@"delUser/")
                               completeBlock:^(NSDictionary *returnDict) {
                                   if ([returnDict[@"state"] integerValue] == 1) {
                                       if (completeblock) {
                                           completeblock();
                                       }
                                   }
   } errorBlock:^(NSError *error) {
       if (errorblock) {
           errorblock(error);
       }
   }];
}

- (void)postUserRegisterWithName:(NSString *)name
                        password:(NSString *)password
                           email:(NSString *)email
                            team:(NSString *)team
                   completeBlock:(void (^)(void))completeblock
                      errorBlock:(void (^)(NSError *error))errorblock
{
    NSMutableDictionary *registerDict = [@{@"username":name,
                                           @"password":password,
                                           @"email":email,
                                           @"team":team}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:registerDict
                                   httpMethod:POST
                                       server:SERVERURL(@"register/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                    if ([returnDict[@"state"] integerValue] == 2 ) {
                                        
                                    }
                                } errorBlock:^(NSError *error) {
                                    NSLog(@"%@",error);
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postUserLoginWithName:(NSString *)name
                     password:(NSString *)password
                completeBlock:(void (^)(void))completeblock
                   errorBlock:(void (^)(NSError *error))errorblock
{
    NSMutableDictionary *loginDict = [@{@"username":name,
                                        @"password":password}mutableCopy];
    
    [RE_SINGLETON(DataPosterManager) postData:loginDict
                                   httpMethod:POST
                                       server:SERVERURL(@"login/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        NSString *userName = returnDict[@"userInfo"][0][@"username"];
                                        NSString *team = returnDict[@"userInfo"][0][@"team"];
                                        NSString *email =  returnDict[@"userInfo"][0][@"email"];
                                        if (userName && team && email) {
                                            userInfo *user = [[userInfo alloc] init];
                                            user.username = userName;
                                            user.email = team;
                                            user.team = email;
                                            [RE_SINGLETON(DataUserManager) saveCutomObject:user objKey:@"userInfo"];
                                            if (completeblock) {
                                                completeblock();
                                            }
                                        }
                                    }
                                    if ([returnDict[@"state"] integerValue] == 2 ) {
                                        
                                    }
                                }errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postUserModifyWithName:(NSString *)name
                      password:(NSString *)password
                         email:(NSString *)email
                         nName:(NSString *)nName
                     nPassword:(NSString *)nPassword
                        nEmail:(NSString *)nEmail
                 completeBlock:(void (^)(void))completeblock
                    errorBlock:(void (^)(NSError *error))errorblock
{
    NSMutableDictionary *modifyDict = [@{@"oriusername":name,
                                         @"oripassword":password,
                                         @"oriemail":email,
                                         @"newusername":nName,
                                         @"newpassword":nPassword,
                                         @"newemail":nEmail}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:modifyDict
                                   httpMethod:POST
                                       server:SERVERURL(@"modifyUser/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict[@"message"]);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                    NSLog(@"%@",returnDict);
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postModuleCreatWithModule:(NSString *)module
                    completeBlock:(void(^)(void))completeblock
                       errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *moduleCreDict = [@{@"module":module}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:moduleCreDict
                                   httpMethod:POST
                                       server:SERVERURL(@"creatModule/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)getModulesCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                     errorBlock:(void(^)(NSError *error))errorblock;
{
    [RE_SINGLETON(DataPosterManager)postData:nil
                                  httpMethod:GET
                                      server:SERVERURL(@"getModules/")
                               completeBlock:^(NSDictionary *returnDict) {
                                   NSLog(@"%@",returnDict);
                                   NSMutableArray *returnArray = [NSMutableArray array];
                                   NSArray *moduleArray = returnDict[@"modules"];
                                   [moduleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                       NSDictionary *moduleDict = obj;
                                       Modules *module = [[Modules alloc] initWithDictionary:moduleDict error:NULL];
                                       [returnArray addObject:module];
                                   }];
                                   NSLog(@"%@",returnArray);
                                   if ([returnDict[@"state"] integerValue] == 1) {
                                       if (completeblock) {
                                           completeblock(returnArray);
                                       }
                                   }
                               } errorBlock:^(NSError *error) {
                                   if (errorblock) {
                                       errorblock(error);
                                   }
                               }];
}

- (void)postModulesDeleteWithModuleId:(NSString *)moduleId
                        CompleteBlock:(void(^)(void))completeblock
                           errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *moduleDict = [@{@"moduleId":moduleId}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:moduleDict
                                   httpMethod:POST
                                       server:SERVERURL(@"delModule/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)getBugsWithKey:(NSDictionary *)key
         completeBlock:(void(^)(NSMutableArray *returnArray))completeblock
            errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *bugsDict = [key mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:bugsDict
                                   httpMethod:POST
                                       server:SERVERURL(@"getMybugs/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSMutableArray *returnArray = [NSMutableArray array];
                                    NSArray *bugArray = returnDict[@"bugs"];
                                    [bugArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        NSDictionary *bugDict = obj;
                                        Bug *bug = [[Bug alloc] initWithDictionary:bugDict error:NULL];
                                        [returnArray addObject:bug];
                                    }];
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock(returnArray);
                                        }
                                    }
                                    NSLog(@"%@",returnArray);
                                } errorBlock:^(NSError *error) {
                                    NSLog(@"%@",error);
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postBugDeleteWithBugId:(NSString *)bugId
                 completeBlock:(void(^)(void))completeblock
                    errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *deleteBugDict = [@{@"bugId":bugId}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:deleteBugDict
                                   httpMethod:POST
                                       server:SERVERURL(@"delBug/")
                                completeBlock:^(NSDictionary *returnDict) {
        if ([returnDict[@"state"] integerValue] == 1) {
            if (completeblock) {
                completeblock();
            }
        }
    } errorBlock:^(NSError *error) {
        if (errorblock) {
            errorblock(error);
        }
    }];
}

- (void)postBugModifyStateWithBugId:(NSString *)bugId
                              state:(NSString *)state
                      completeBlock:(void(^)(void))completeblock
                         errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *modifyBugDict = [@{@"bugId":bugId,@"state":state}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:modifyBugDict
                                   httpMethod:POST
                                       server:SERVERURL(@"modifyBug/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)getTeamsCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                   errorBlock:(void(^)(NSError *error))errorblock
{
    [RE_SINGLETON(DataPosterManager) postData:nil httpMethod:GET
                                       server:SERVERURL(@"getTeams/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSMutableArray *returnArray = [NSMutableArray array];
                                    NSArray *teamArray = returnDict[@"teams"];
                                    [teamArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        NSDictionary *teamDict = obj;
                                        Team *team = [[Team alloc] initWithDictionary:teamDict error:NULL];
                                        [returnArray addObject:team];
                                    }];
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock(returnArray);
                                        }
                                    }
                                    NSLog(@"%@",returnArray);
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postTeamsDelete:(NSString *)teamId
          completeBlock:(void(^)(void))completeblock
             errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *teamDict = [@{@"teamId":teamId}mutableCopy];
    [RE_SINGLETON(DataPosterManager)postData:teamDict
                                  httpMethod:POST
                                      server:SERVERURL(@"delTeam/")
                               completeBlock:^(NSDictionary *returnDict) {
                                   NSLog(@"%@",returnDict);
                                   if ([returnDict[@"state"] integerValue] == 1) {
                                       if (completeblock) {
                                           completeblock();
                                       }
                                   }
                               } errorBlock:^(NSError *error) {
                                   if (errorblock) {
                                       errorblock(error);
                                   }
                               }];
}

- (void)postTeamsCreatWithTeamName:(NSString *)teamName
                     completeBlock:(void(^)(void))completeblock
                        errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *teamCreatDict = [@{@"team":teamName}mutableCopy];
    [RE_SINGLETON(DataPosterManager)postData:teamCreatDict
                                  httpMethod:POST
                                      server:SERVERURL(@"creatTeam/")
                               completeBlock:^(NSDictionary *returnDict) {
                                   if ([returnDict[@"state"] integerValue] == 1) {
                                       if (completeblock) {
                                           completeblock();
                                       }
                                   }
                               } errorBlock:^(NSError *error) {
                                   
                               }];
}

- (void)getProjectsCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                      errorBlock:(void(^)(NSError *error))errorblock
{
    [RE_SINGLETON(DataPosterManager) postData:nil
                                   httpMethod:GET
                                       server:SERVERURL(@"getProjects/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSMutableArray *returnArray = [NSMutableArray array];
                                    NSArray *projectArray = returnDict[@"projects"];
                                    [projectArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        NSDictionary *projectDict = obj;
                                        Project *project = [[Project alloc] initWithDictionary:projectDict error:NULL];
                                        [returnArray addObject:project];
                                    }];
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock(returnArray);
                                        }
                                    }
                                    NSLog(@"%@",returnArray);
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postProjectsCreatWithProject:(NSString *)project
                             version:(NSString *)version
                       completeBlock:(void(^)(void))completeblock
                          errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *creatprojectDict = [@{@"project":project,@"version":version}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:creatprojectDict
                                   httpMethod:POST
                                       server:SERVERURL(@"creatProject/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postProjectDeleteWithProjectId:(NSString *)projectId
                         completeBlock:(void(^)(void))completeblock
                            errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *deleteprojectDict = [@{@"projectId":projectId}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:deleteprojectDict
                                   httpMethod:POST
                                       server:SERVERURL(@"delProject/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)getVersionsCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                      errorBlock:(void(^)(NSError *error))errorblock
{
    [RE_SINGLETON(DataPosterManager) postData:nil
                                   httpMethod:GET
                                       server:SERVERURL(@"getVersions/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSMutableArray *returnArray = [NSMutableArray array];
                                    NSArray *versionArray = returnDict[@"versions"];
                                    [versionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        NSDictionary *versionDict = obj;
                                        Version *version = [[Version alloc] initWithDictionary:versionDict error:NULL];
                                        [returnArray addObject:version];
                                    }];
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock(returnArray);
                                        }
                                    }
                                    NSLog(@"%@",returnArray);
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postVersionDeleteWithVersionId:(NSString *)versionId
                         completeBlock:(void(^)(void))completeblock
                            errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *versionDelDict = [@{@"versionId":versionId}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:versionDelDict
                                   httpMethod:POST
                                       server:SERVERURL(@"delVersion/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock();
                                        }
                                    }
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

- (void)postVersionCreatWithVersion:(NSString *)version
                      completeBlock:(void(^)(NSMutableArray *returnArray))completeblock
                         errorBlock:(void(^)(NSError *error))errorblock
{
    NSMutableDictionary *versioncreDict = [@{@"version":version}mutableCopy];
    [RE_SINGLETON(DataPosterManager) postData:versioncreDict
                                   httpMethod:POST
                                       server:SERVERURL(@"creatVersion/")
                                completeBlock:^(NSDictionary *returnDict) {
                                    NSLog(@"%@",returnDict);
                                    NSMutableArray *returnArray = [NSMutableArray array];
                                    NSArray *versionArray = returnDict[@"versions"];
                                    [versionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        NSDictionary *versionDict = obj;
                                        Version *version = [[Version alloc] initWithDictionary:versionDict error:NULL];
                                        [returnArray addObject:version];
                                    }];
                                    if ([returnDict[@"state"] integerValue] == 1) {
                                        if (completeblock) {
                                            completeblock(returnArray);
                                        }
                                    }
                                    NSLog(@"%@",returnArray);
                                } errorBlock:^(NSError *error) {
                                    if (errorblock) {
                                        errorblock(error);
                                    }
                                }];
}

@end
