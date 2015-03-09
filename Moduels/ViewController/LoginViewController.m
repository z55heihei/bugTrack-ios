//
//  LoginViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-26.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "LoginViewController.h"
#import "APService.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
- (IBAction)Login:(id)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)Login:(id)sender
{
    [self postLoginData];
}

- (IBAction)respond:(id)sender
{
    [_userNameTextFeild resignFirstResponder];
    [_passwordTextFeild resignFirstResponder];
}

- (void)postLoginData
{
    NSString *userName = _userNameTextFeild.text;
    NSString *password = _passwordTextFeild.text;

    [RE_SINGLETON(DataGeterManager) postUserLoginWithName:userName
                                                 password:password
                                            completeBlock:^{
                                                [self IMLogin:userName password:password];
                                                [self alignsRegister:userName];
                                            } errorBlock:^(NSError *error) {
                                                
                                            }];
}

- (void)alignsRegister:(NSString *)userName
{
    [APService setAlias:userName callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}

- (void)IMLogin:(NSString *)userName password:(NSString *)password
{
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userName
                                                         password:password
                                                   withCompletion:^(NSString *username, NSString *password, EMError *error) {
                                                       [self dismissViewControllerAnimated:YES completion:NULL];
                                                       if (!error) {
                                                           NSLog(@"注册成功,请登录");
                                                       }else{
                                                           switch (error.errorCode) {
                                                               case EMErrorServerNotReachable:
                                                                   NSLog(@"连接服务器失败!");
                                                                   break;
                                                               case EMErrorServerDuplicatedAccount:
                                                                   NSLog(@"您注册的用户已存在!");
                                                                   break;
                                                               case EMErrorServerTimeout:
                                                                   NSLog(@"连接服务器超时!");
                                                                   break;
                                                               default:
                                                                   NSLog(@"注册失败");
                                                                   break;
                                                           }
                                                       }
                                                   } onQueue:nil];
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


@end
