//
//  projectManageCreatViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-30.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

@interface projectManagerCreatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@end

@implementation projectManagerCreatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


#import "projectManageCreatViewController.h"

@interface projectManageCreatViewController ()
@property (nonatomic,strong) NSDictionary *paramDictory;
@property (nonatomic,strong) NSMutableDictionary *postDictory;
@end

@implementation projectManageCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.paramDictory = self.user ? self.user.toDictionary : self.project
    ? self.project.toDictionary : self.team
    ? self.team.toDictionary : self.module
    ?  self.module.toDictionary : self.version.toDictionary;
    
    self.postDictory = [NSMutableDictionary dictionary];
    self.title = @"创建";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(creatProject)];
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
    return [self.paramDictory count] - 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideniferstring = @"projectManageCreatViewCell";
    projectManagerCreatCell *cell = (projectManagerCreatCell *)[tableView dequeueReusableCellWithIdentifier:ideniferstring];
    
    NSInteger row = [indexPath row] + 1;
    NSString *name = [self.paramDictory allKeys][row];
    cell.nameLable.text = name;
    cell.contentTextField.tag = row;
    [cell.contentTextField addTarget:self action:@selector(getparamContent:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)getparamContent:(UITextField *)textField
{
    NSInteger row = textField.tag;
    NSString *value = textField.text;
    NSString *key = [self.paramDictory allKeys][row];
    [self.postDictory setObject:value forKey:key];
    NSLog(@"%@",self.postDictory);
}



- (void)creatProject
{
    [self creatProjectData];
}

- (void)creatProjectData
{
    if (self.team) {
        NSString *team = [self.postDictory allValues][0];
        [RE_SINGLETON(DataGeterManager) postTeamsCreatWithTeamName:team
                                                     completeBlock:^{
                                                         [self popProjectManagerController];
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
    if (self.project) {
        NSString *project = [self.postDictory allValues][0];
        NSString *version = [self.postDictory allValues][1];
        [RE_SINGLETON(DataGeterManager) postProjectsCreatWithProject:project
                                                             version:version
                                                       completeBlock:^{
                                                            [self popProjectManagerController];
                                                       } errorBlock:^(NSError *error) {
                                                           
                                                       }];
    }

    
    if (self.module) {
        NSString *module = [self.postDictory allValues][0];
        [RE_SINGLETON(DataGeterManager) postModuleCreatWithModule:module
                                                    completeBlock:^{
                                                         [self popProjectManagerController];
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
    if (self.version) {
        NSString *version = [self.postDictory allValues][0];
        [RE_SINGLETON(DataGeterManager) postVersionCreatWithVersion:version
                                                      completeBlock:^(NSMutableArray *returnArray) {
                                                           [self popProjectManagerController];
                                                      }errorBlock:^(NSError *error) {
                                                          
                                                      }];
    }
}

- (void)popProjectManagerController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end

