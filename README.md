# bugTrack-ios
bugTrack-ios客户端构建于bugTrack-django后台管理，可以创建发布bug，修改bug状态，项目版本管理，接受bug修复通知，内置im等功能

#Vendors:
[EaseMobSDK](http://www.easemob.com/docs/ios/quickstart/):环信即时通讯SDK

#Api:
```bash
/*!
 *  @author zhangyuanwu
 *
 *  @brief  获取所有用户
 *  @param userid   用户id
 *  @param complete 成功返回block 数组返回
 *  @param error    错误返回
 *
 *  @since 0.1
 */

- (void)getUsersDataCompleteBlock:(void (^)(NSMutableArray *returnArray))completeblock
                       errorBlock:(void (^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  删除用户
 *
 *  @param completeblock 成功返回
 *  @param errorblock    失败返回
 *
 *  @since 0.1
 */
- (void)postUserDeleteWithId:(NSString *)userId
               completeBlock:(void(^)(void))completeblock
                  errorBlock:(void(^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  注册
 *
 *  @param name     用户名
 *  @param password 密码
 *  @param password 邮件
 *  @param password 团队 传team id
 *  @param complete 成功返回 返回状态
 *  @param error    错误返回
 *
 *  @since 0.1
 */

- (void)postUserRegisterWithName:(NSString *)name
                        password:(NSString *)password
                           email:(NSString *)email
                            team:(NSString *)team
                   completeBlock:(void (^)(void))completeblock
                      errorBlock:(void (^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  登录
 *
 *  @param name     用户名
 *  @param password 密码
 *  @param complete 成功返回
 *  @param error    错误返回
 *
 *  @since 0.1
 */
- (void)postUserLoginWithName:(NSString *)name
                     password:(NSString *)password
                completeBlock:(void (^)(void))completeblock
                   errorBlock:(void (^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  修改用户信息
 *
 *  @param name      原用户名
 *  @param password  原密码
 *  @param email     原邮件
 *  @param nName     新用户名
 *  @param nPassword 新密码
 *  @param nEmail    新邮件
 *  @param complete  成功返回
 *  @param error     错误返回
 *
 *  @since 0.1
 */

- (void)postUserModifyWithName:(NSString *)name
                      password:(NSString *)password
                         email:(NSString *)email
                         nName:(NSString *)nName
                     nPassword:(NSString *)nPassword
                        nEmail:(NSString *)nEmail
                 completeBlock:(void (^)(void))completeblock
                    errorBlock:(void (^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  创建模块
 *
 *  @param module   模块名字
 *  @param complete 成功放回
 *  @param error    失败返回
 *
 *  @since 0.1
 */
- (void)postModuleCreatWithModule:(NSString *)module
                    completeBlock:(void(^)(void))completeblock
                       errorBlock:(void(^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  获取所有模块
 *
 *  @param complete 成功返回
 *  @param error    失败返回
 *
 *  @since 0.1
 */
- (void)getModulesCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                     errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  删除模块
 *
 *  @param moduleId 模块id
 *  @param complete 成功返回
 *  @param error    失败返回
 *
 *  @since 0.1
 */
- (void)postModulesDeleteWithModuleId:(NSString *)moduleId
                        CompleteBlock:(void(^)(void))completeblock
                           errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  根据Key获取所有bug
 *
 *  @param key      key:username(用户名):content project(项目):content version（版本）:content urgency（程度）:content date（时间）:content
 *  @param complete 成功返回数组
 *  @param error    失败返回
 *
 *  @since 0.1
 */
- (void)getBugsWithKey:(NSDictionary *)key
         completeBlock:(void(^)(NSMutableArray *returnArray))completeblock
            errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  根据id删除bug
 *
 *  @param bugId         bugid
 *  @param completeblock 成功返回
 *  @param errorblock    失败返回
 *
 *  @since 0.1
 */
- (void)postBugDeleteWithBugId:(NSString *)bugId
                 completeBlock:(void(^)(void))completeblock
                    errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  修改bug状态
 *
 *  @param bugId         bugId
 *  @param state         state
 *  @param completeblock 成功返回
 *  @param errorblock    失败返回
 *
 *  @since 0.1
 */
- (void)postBugModifyStateWithBugId:(NSString *)bugId
                              state:(NSString *)state
                      completeBlock:(void(^)(void))completeblock
                         errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  获取所有团队
 *
 *  @param complete 成功返回
 *  @param error    错误返回
 *
 *  @since 0.1
 */

- (void)getTeamsCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                   errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  删除团队
 *
 *  @param teamId   团队id
 *  @param complete 成功返回
 *  @param error    错误返回
 *
 *  @since 0.1
 */
- (void)postTeamsDelete:(NSString *)teamId
          completeBlock:(void(^)(void))completeblock
             errorBlock:(void(^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  创建团队
 *
 *  @param teamName      团队名称
 *  @param completeblock 成功返回
 *  @param errorblock    失败返回
 *
 *  @since 0.1
 */
- (void)postTeamsCreatWithTeamName:(NSString *)teamName
                     completeBlock:(void(^)(void))completeblock
                        errorBlock:(void(^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  获取所有项目
 *
 *  @param complete 成功返回
 *  @param error    失败返回
 *
 *  @since 0.1
 */
- (void)getProjectsCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                      errorBlock:(void(^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief  创建项目
 *
 *  @param project  项目名字
 *  @param version  版本号
 *  @param complete 成功返回
 *  @param error    错误返回
 *
 *  @since 0.1
 */
- (void)postProjectsCreatWithProject:(NSString *)project
                             version:(NSString *)version
                       completeBlock:(void(^)(void))completeblock
                          errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  删除项目
 *
 *  @param projectId 项目id
 *  @param complete  成功返回
 *  @param error     错误返回
 *
 *  @since 0.1
 */
- (void)postProjectDeleteWithProjectId:(NSString *)projectId
                         completeBlock:(void(^)(void))completeblock
                            errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  获取所有版本
 *
 *  @param complete 成功返回
 *  @param error    错误返回
 *
 *  @since 0.1
 */
- (void)getVersionsCompleteBlock:(void(^)(NSMutableArray *returnArray))completeblock
                      errorBlock:(void(^)(NSError *error))errorblock;

/*!
 *  @author zhangyuanwu
 *
 *  @brief  删除版本
 *
 *  @param versionId 版本id
 *  @param complete  成功返回
 *  @param error     失败返回
 *
 *  @since 0.1
 */
- (void)postVersionDeleteWithVersionId:(NSString *)versionId
                         completeBlock:(void(^)(void))completeblock
                            errorBlock:(void(^)(NSError *error))errorblock;


/*!
 *  @author zhangyuanwu
 *
 *  @brief 创建版本
 *
 *  @param version  版本号
 *  @param complete 成功返回
 *  @param error    失败返回
 *
 *  @since 0.1
 */
- (void)postVersionCreatWithVersion:(NSString *)version
                      completeBlock:(void(^)(NSMutableArray *returnArray))completeblock
                         errorBlock:(void(^)(NSError *error))errorblock;
```

