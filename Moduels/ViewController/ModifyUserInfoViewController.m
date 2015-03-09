//
//  ModifyUserInfoViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-30.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "ModifyUserInfoViewController.h"

@interface ModifyUserInfoViewController ()
{
    __weak IBOutlet UITextField *oriUserNameTextField;
    __weak IBOutlet UITextField *newUserNameTextField;
    __weak IBOutlet UITextField *oriPassWordTextField;
    __weak IBOutlet UITextField *newPassWordTextField;
    __weak IBOutlet UITextField *oriEmailTextField;
    __weak IBOutlet UITextField *newEmailTextField;
    __weak IBOutlet UITextField *oriTeamTextField;
    __weak IBOutlet UITextField *newTeamTextField;
    
}
@end

@implementation ModifyUserInfoViewController

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
- (IBAction)modifyUserInfo:(id)sender
{
    [self postModifyUserData];
}

- (void)postModifyUserData
{
    NSString *oriUserName = oriUserNameTextField.text;
    NSString *newUserName = newUserNameTextField.text;
    NSString *oriPassWord = oriPassWordTextField.text;
    NSString *newPassWord = newPassWordTextField.text;
    NSString *oriEmail = oriEmailTextField.text;
    NSString *newEmail = newEmailTextField.text;
    NSString *oriTeam  = oriTeamTextField.text;
    NSString *newTeam  = newTeamTextField.text;
    
    [RE_SINGLETON(DataGeterManager)postUserModifyWithName:oriUserName
                                                 password:oriPassWord
                                                    email:oriEmail
                                                    nName:newUserName
                                                nPassword:newPassWord
                                                   nEmail:newEmail
                                            completeBlock:^{
                                                [self popLoginController];
                                            } errorBlock:^(NSError *error) {
                                                
                                            }];
}

- (void)popLoginController
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
