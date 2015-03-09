//
//  DataPosterManager.m
//  bugTrack
//
//  Created by zhangyw on 14-12-22.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "DataPosterManager.h"

@interface DataPosterManager ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *manage;

@end

@implementation DataPosterManager

DEF_SINGLETON(DataPosterManager)


- (id)init
{
    self = [super init];
    if (self) {
        _manage = [AFHTTPRequestOperationManager manager];
        _manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

- (void)postData:(NSMutableDictionary *)params
      httpMethod:(HttpMethod)method
          server:(NSString *)server
   completeBlock:(getDataPosterCompleteBlock)completeblock
      errorBlock:(getDataPosterErrorBlock)errorblock
{
    if (method == GET) {
        [_manage GET:server
          parameters:params
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSDictionary *returnDict = (NSDictionary *)responseObject;
                 if (completeblock) {
                     completeblock(returnDict);
                 }
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if (errorblock) {
                     errorblock(error);
                 }
             }];
    }
    
    if (method == POST) {
        [_manage POST:server
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *returnDict = (NSDictionary *)responseObject;
                  if (completeblock) {
                      completeblock(returnDict);
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  if (errorblock) {
                      errorblock(error);
                  }
              }];
    }
}

@end
