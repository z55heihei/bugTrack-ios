//
//  projectManagerDetailViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-29.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "projectManagerDetailViewController.h"
#import "projectManageCreatViewController.h"

@interface projectManagerDetailViewController () <UIActionSheetDelegate>
@property (nonatomic,strong) NSDictionary *paramDictory;
@end

@implementation projectManagerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.paramDictory = self.user ? self.user.toDictionary : self.project
    ? self.project.toDictionary : self.team
    ? self.team.toDictionary : self.module
    ?  self.module.toDictionary : self.version.toDictionary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.paramDictory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideniferstring = @"cellIdenifer";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ideniferstring];
    
    if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ideniferstring];
    }
    
    NSInteger row = [indexPath row];
    NSString *name = [self.paramDictory allKeys][row];
    NSString *content = [self.paramDictory allValues][row];
    NSString *cellContent = [NSString stringWithFormat:@"%@:%@",name,content];
    cell.textLabel.text = cellContent;
    
    return cell;
}



- (IBAction)operationProjectUserTeam:(id)sender
{
    
    UIActionSheet *operationAction = [[UIActionSheet alloc] initWithTitle:@"操作"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"新建",@"删除",nil];
    [operationAction showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.firstOtherButtonIndex+ 1) { //删除
        [self postDeletProjectUserTeamData];
    }
    if (buttonIndex == actionSheet.firstOtherButtonIndex) { //新建
        [self postCreatProjectUserTeamData];
    }
}


- (void)postDeletProjectUserTeamData
{
    if (self.project) {//删除项目
        NSString *projectId = [NSString stringWithFormat:@"%d",self.project.id];
        [RE_SINGLETON(DataGeterManager) postProjectDeleteWithProjectId:projectId
                                                         completeBlock:^{
                                                             [self popProjectTeamManagerController];
                                                         } errorBlock:^(NSError *error) {
                                                             
                                                         }];
    }
    
    if (self.user) {//删除用户
        NSString *userId = [NSString stringWithFormat:@"%d",self.user.id];
        [RE_SINGLETON(DataGeterManager) postUserDeleteWithId:userId
                                               completeBlock:^{
                                                   [self popProjectTeamManagerController];
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
    if (self.team) {//删除团队
        NSString *teamId = [NSString stringWithFormat:@"%d",self.team.id];
        [RE_SINGLETON(DataGeterManager) postTeamsDelete:teamId
                                          completeBlock:^{
                                              [self popProjectTeamManagerController];
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
    if (self.module) {//删除模块
        NSString *moduleId = [NSString stringWithFormat:@"%d",self.module.id];
        [RE_SINGLETON(DataGeterManager) postModulesDeleteWithModuleId:moduleId
                                                        CompleteBlock:^{
                                                            [self popProjectTeamManagerController];
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
    if (self.version) {//删除版本
        NSString *versionId = [NSString stringWithFormat:@"%d",self.version.id];
        [RE_SINGLETON(DataGeterManager) postVersionDeleteWithVersionId:versionId
                                                         completeBlock:^{
                                                             [self popProjectTeamManagerController];
                                                         } errorBlock:^(NSError *error) {
                                                             
                                                         }];
    }
}

- (void)postCreatProjectUserTeamData
{
    projectManageCreatViewController *projectManagerCreatVC = [self.storyboard instantiateViewControllerWithIdentifier:@"projectManageCreatViewController"];
    projectManagerCreatVC.project = self.project;
    projectManagerCreatVC.team = self.team;
    projectManagerCreatVC.user = self.user;
    projectManagerCreatVC.module = self.module;
    projectManagerCreatVC.version = self.version;
    [self.navigationController pushViewController:projectManagerCreatVC animated:YES];
}



- (void)popProjectTeamManagerController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
