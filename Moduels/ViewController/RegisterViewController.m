//
//  RegisterViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-26.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *teamTextFeild;
- (IBAction)Resigter:(id)sender;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Resigter:(id)sender
{
    [self postResigterData];
}

- (void)postResigterData
{
    NSString *userName = _userNameTextFeild.text;
    NSString *password = _passwordTextFeild.text;
    NSString *email = _emailTextFeild.text;
    NSString *team  = _teamTextFeild.text;

    [self IMRegister:userName password:password];
    
    [RE_SINGLETON(DataGeterManager) postUserRegisterWithName:userName
                                                    password:password
                                                       email:email
                                                        team:team
                                               completeBlock:^{
                                                   
                                               } errorBlock:^(NSError *error){
                                                   
                                               }];

}

- (void)IMRegister:(NSString *)userName password:(NSString *)password
{
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userName
                                                         password:password
                                                   withCompletion:^(NSString *username, NSString *password, EMError *error) {
                                                       [self popLoginController];
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

- (void)popLoginController
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
