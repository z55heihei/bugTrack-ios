//
//  bugManageCreateViewController.m
//  bugTrack
//
//  Created by zhangyw on 15-2-26.
//  Copyright (c) 2015年 zyw. All rights reserved.
//


@interface bugManagerCreatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@end

@implementation bugManagerCreatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


#import "bugManageCreateViewController.h"
#import "AppDelegate.h"

@interface bugManageCreateViewController () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *pickView;
    NSString  *pickSelName;
    NSString *currentKey;
    UIPickerView *pickerView;
}

@property (nonatomic,strong) NSMutableDictionary *postDictory;
@property (nonatomic,strong) NSMutableArray *projectArray;
@property (nonatomic,strong) NSMutableArray *teamArray;
@property (nonatomic,strong) NSMutableArray *userArray;
@property (nonatomic,strong) NSMutableArray *modulesArray;
@property (nonatomic,strong) NSMutableArray *versionArray;

@end


@implementation bugManageCreateViewController


- (void)getMyProjectData
{
    self.projectArray = [NSMutableArray array];
    self.versionArray = [NSMutableArray array];
    self.userArray  = [NSMutableArray array];
    self.modulesArray  = [NSMutableArray array];
    
    //所有项目
    [RE_SINGLETON(DataGeterManager) getProjectsCompleteBlock:^(NSMutableArray *returnArray) {
        self.projectArray = returnArray;
        self.postDictory = [@{@"项目":self.projectArray,
                              @"版本":self.versionArray,
                              @"分发给":self.userArray,
                              @"紧急严重":@[@"低",@"中",@"高",@"严重"],
                              @"发布人":self.userArray,
                              @"问题详情":@[],
                              @"所属模块":self.modulesArray,
                              @"平台":@[@"ios",@"android"],
                              @"联系方式":@[],
                              @"状态":@[@"未解决",@"已解决",@"正在解决"],
                              @"是否推送":@[@"是",@"否"]}mutableCopy];
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
    //所有团队
    [RE_SINGLETON(DataGeterManager) getTeamsCompleteBlock:^(NSMutableArray *returnArray) {
        self.teamArray = returnArray;
    } errorBlock:^(NSError *error) {
        
    }];
    
    //所有用户
    [RE_SINGLETON(DataGeterManager) getUsersDataCompleteBlock:^(NSMutableArray *returnArray) {
        self.userArray = returnArray;
        self.postDictory = [@{@"项目":self.projectArray,
                              @"版本":self.versionArray,
                              @"分发给":self.userArray,
                              @"紧急严重":@[@"低",@"中",@"高",@"严重"],
                              @"发布人":self.userArray,
                              @"问题详情":@[],
                              @"所属模块":self.modulesArray,
                              @"平台":@[@"ios",@"android"],
                              @"联系方式":@[],
                              @"状态":@[@"未解决",@"已解决",@"正在解决"],
                              @"是否推送":@[@"是",@"否"]}mutableCopy];
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
    
    //所有版本
    [RE_SINGLETON(DataGeterManager) getVersionsCompleteBlock:^(NSMutableArray *returnArray) {
        self.versionArray = returnArray;
        self.postDictory = [@{@"项目":self.projectArray,
                              @"版本":self.versionArray,
                              @"分发给":self.userArray,
                              @"紧急严重":@[@"低",@"中",@"高",@"严重"],
                              @"发布人":self.userArray,
                              @"问题详情":@[],
                              @"所属模块":self.modulesArray,
                              @"平台":@[@"ios",@"android"],
                              @"联系方式":@[],
                              @"状态":@[@"未解决",@"已解决",@"正在解决"],
                              @"是否推送":@[@"是",@"否"]}mutableCopy];
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
    //项目模块
    [RE_SINGLETON(DataGeterManager) getModulesCompleteBlock:^(NSMutableArray *returnArray) {
        self.modulesArray = returnArray;
        self.postDictory = [@{@"项目":self.projectArray,
                              @"版本":self.versionArray,
                              @"分发给":self.userArray,
                              @"紧急严重":@[@"低",@"中",@"高",@"严重"],
                              @"发布人":self.userArray,
                              @"问题详情":@[],
                              @"所属模块":self.modulesArray,
                              @"平台":@[@"ios",@"android"],
                              @"联系方式":@[],
                              @"状态":@[@"未解决",@"已解决",@"正在解决"],
                              @"是否推送":@[@"是",@"否"]}mutableCopy];
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getMyProjectData];
    
    pickView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), 320, 220)];
    pickView.backgroundColor = [UIColor whiteColor];

    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(confimPickerView:)];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(cancelPickerView:)];
    [items addObject:cancelBtn];
    [items addObject:flexibleSpaceItem];
    [items addObject:confirmBtn];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.items = items;
    [pickView addSubview:toolbar];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40, 320, 180)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [pickView addSubview:pickerView];
    [[AppDelegate appDeleagte].window addSubview:pickView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postCreatData:(id)sender
{
    
}

- (void)dealloc
{
    [self pickerViewHiden];
}


#pragma mark - pickerView Aniamtion

- (void)pickerViewShow
{
    [UIView animateWithDuration:0.18
                     animations:^{
                         pickView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)
                                                     - CGRectGetHeight(pickView.frame),
                                                     CGRectGetWidth(pickView.frame),
                                                     CGRectGetHeight(pickView.frame));
                        
    }completion:^(BOOL finished){
         [pickerView reloadAllComponents];
    }];
}

- (void)pickerViewHiden
{
    [UIView animateWithDuration:0.18
                     animations:^{
                         pickView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame),
                                                     CGRectGetWidth(pickView.frame),
                                                     CGRectGetHeight(pickView.frame));
                     }completion:^(BOOL finished){
                         [self.tableView reloadData];
                     }];
}

#pragma mark - pickerView Action

- (void)cancelPickerView:(id)sender
{
    [self pickerViewHiden];
}

- (void)confimPickerView:(id)sender
{
    [self pickerViewHiden];
}


#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *selectArray = self.postDictory[currentKey];
    return [selectArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString  *pickContent ;
    NSArray *selectArray = self.postDictory[currentKey];
    id obj = selectArray[row];
    
    if ([obj isKindOfClass:[Modules class]]) {
        Modules *modles = selectArray[row];
        pickContent = modles.module;
    }else if ([obj isKindOfClass:[Project class]]) {
        Project *project = selectArray[row];
        pickContent = project.project;
    }else if ([obj isKindOfClass:[Team class]]) {
        Team *team = selectArray[row];
        pickContent = team.team;
    }else if ([obj isKindOfClass:[User class]]) {
        User *user = selectArray[row];
        pickContent = user.username;
    }else if ([obj isKindOfClass:[Version class]]) {
       Version  *version = selectArray[row];
        pickContent = version.version;
    }else if ([obj isKindOfClass:[Modules class]]) {
        Modules  *module = selectArray[row];
        pickContent = module.module;
    }else{
        pickContent = selectArray[row];
    }
    
    return pickContent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *selectArray = self.postDictory[currentKey];
    id obj = selectArray[row];
    
    if ([obj isKindOfClass:[Modules class]]) {
        Modules *modles = selectArray[row];
        pickSelName = modles.module;
    }else if ([obj isKindOfClass:[Project class]]) {
        Project *project = selectArray[row];
        pickSelName = project.project;
    }else if ([obj isKindOfClass:[Team class]]) {
        Team *team = selectArray[row];
        pickSelName = team.team;
    }else if ([obj isKindOfClass:[User class]]) {
        User *user = selectArray[row];
        pickSelName = user.username;
    }else if ([obj isKindOfClass:[Version class]]) {
        Version  *version = selectArray[row];
        pickSelName = version.version;
    }else if ([obj isKindOfClass:[Modules class]]) {
        Modules  *module = selectArray[row];
        pickSelName = module.module;
    }else{
        pickSelName = selectArray[row];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postDictory count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideniferstring = @"bugManagerCreatCell";
    bugManagerCreatCell *cell = (bugManagerCreatCell *)[tableView dequeueReusableCellWithIdentifier:ideniferstring];
    
    NSInteger row = [indexPath row];
    NSString *name = [self.postDictory allKeys][row];
    
    cell.nameLable.text = name;
    cell.contentLable.text = pickSelName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    currentKey = [self.postDictory allKeys][row];
    NSArray *selectArray = self.postDictory[currentKey];
    if ([selectArray count] > 0) {
        [self pickerViewShow];
    }
}



@end
