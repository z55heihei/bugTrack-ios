//
//  ProjectTeamManagerViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-29.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "ProjectTeamManagerViewController.h"

@interface ProjectTeamManagerViewController ()
@property (weak, nonatomic) IBOutlet UITableView *projectTeamManagerTableView;
@property (nonatomic,strong) NSMutableArray *projectArray;
@property (nonatomic,strong) NSMutableArray *teamArray;
@property (nonatomic,strong) NSMutableArray *userArray;
@property (nonatomic,strong) NSMutableArray *modulesArray;
@property (nonatomic,strong) NSMutableArray *versionArray;
@property (nonatomic,strong) UIStoryboardSegue *segue;
@end

@implementation ProjectTeamManagerViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getMyProjectData];
}


- (void)getMyProjectData
{
    //所有项目
    [RE_SINGLETON(DataGeterManager) getProjectsCompleteBlock:^(NSMutableArray *returnArray) {
        self.projectArray = returnArray;
        [self.projectTeamManagerTableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
    //所有团队
    [RE_SINGLETON(DataGeterManager) getTeamsCompleteBlock:^(NSMutableArray *returnArray) {
        self.teamArray = returnArray;
        [self.projectTeamManagerTableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
    //所有用户
    [RE_SINGLETON(DataGeterManager) getUsersDataCompleteBlock:^(NSMutableArray *returnArray) {
        self.userArray = returnArray;
        [self.projectTeamManagerTableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
    
    //所有版本
    [RE_SINGLETON(DataGeterManager) getVersionsCompleteBlock:^(NSMutableArray *returnArray) {
        self.versionArray = returnArray;
        [self.projectTeamManagerTableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
    //项目模块
    [RE_SINGLETON(DataGeterManager) getModulesCompleteBlock:^(NSMutableArray *returnArray) {
        self.modulesArray = returnArray;
        [self.projectTeamManagerTableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.segue = segue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.projectArray count];
            break;
        case 1:
            return [self.teamArray count];
            break;
        case 2:
            return [self.userArray count];
            break;
        case 3:
            return [self.modulesArray count];
            break;
        case 4:
            return [self.versionArray count];
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleSection[5] = {@"项目",@"团队",@"人员",@"模块",@"版本"};
    
    return titleSection[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideniferstring = @"projectManageCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ideniferstring];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ideniferstring];
    }
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    switch (section) {
        case 0:
        {
            if ([self.projectArray count] > row) {
                Project *project = self.projectArray[row];
                NSString *projectName = project.project;
                cell.textLabel.text = projectName;
            }
        }
            break;
        case 1:
        {
            if ([self.teamArray count] > row) {
                Team *team = self.teamArray[row];
                NSString *teamName = team.team;
                cell.textLabel.text = teamName;
            }
        }
            break;
        case 2:
        {
            if ([self.userArray count] > row) {
                User *user  = self.userArray[row];
                NSString *username = user.username;
                cell.textLabel.text = username;
            }
        }
            break;
        case 3:
        {
            if ([self.modulesArray count] > row) {
                Modules *module = self.modulesArray[row];
                NSString *mduleName = module.module;
                cell.textLabel.text = mduleName;
            }
        }
        case 4:
        {
            if ([self.versionArray count] > row) {
                Version *version = self.versionArray[row];
                NSString *versionName = version.version;
                cell.textLabel.text = versionName;
            }
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    UIViewController *viewController = _segue.destinationViewController;
    switch (section) {
        case 0:
        {
            Project *project = self.projectArray[row];
            [viewController setValue:project forKey:@"project"];
        }
            break;
        case 1:
        {
            Team *team = self.teamArray[row];
            [viewController setValue:team forKey:@"team"];
        }
            break;
        case 2:
        {
            User *user  = self.userArray[row];
            [viewController setValue:user forKey:@"user"];
        }
            break;
        case 3:
        {
            Modules *module = self.modulesArray[row];
            [viewController setValue:module forKey:@"module"];
        }
            break;
        case 4:
        {
            Version *version = self.versionArray[row];
            [viewController setValue:version forKey:@"version"];
        }
            break;
        default:
            break;
    }
}


@end
