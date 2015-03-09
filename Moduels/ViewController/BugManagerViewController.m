//
//  BugManagerViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-26.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "BugManagerViewController.h"
#import "LoginViewController.h"

@interface BugManagerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bugManageTableView;
@property (nonatomic,strong) NSMutableArray *finishReturnArray;
@property (nonatomic,strong) NSMutableArray *unfinishReturnArray;
@property (nonatomic,strong) NSMutableArray *fixingReturnArray;
@property (nonatomic,strong) UIStoryboardSegue *segue;
@end

@implementation BugManagerViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.finishReturnArray count] == 0) {
        [self getMyBugsData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
}

- (void)getMyBugsData
{
    //已经完成
    [RE_SINGLETON(DataGeterManager) getBugsWithKey:@{@"state":@"3"}
                                     completeBlock:^(NSMutableArray *returnArray) {
                                         self.finishReturnArray = [NSMutableArray arrayWithArray:returnArray];
                                         [self.bugManageTableView reloadData];
                                     } errorBlock:^(NSError *error) {
                                         
                                     }];
    //未完成
    [RE_SINGLETON(DataGeterManager) getBugsWithKey:@{@"state":@"1"}
                                     completeBlock:^(NSMutableArray *returnArray) {
                                         self.unfinishReturnArray = [NSMutableArray arrayWithArray:returnArray];
                                         [self.bugManageTableView reloadData];
                                     } errorBlock:^(NSError *error) {
                                         
                                     }];
    //正在解决
    [RE_SINGLETON(DataGeterManager) getBugsWithKey:@{@"state":@"2"}
                                     completeBlock:^(NSMutableArray *returnArray) {
                                         self.fixingReturnArray = [NSMutableArray arrayWithArray:returnArray];
                                         [self.bugManageTableView reloadData];
                                     } errorBlock:^(NSError *error) {
                                         
                                     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.segue = segue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
         return [self.finishReturnArray count];
    }
    if (section == 1) {
        return [self.unfinishReturnArray count];
    }
    if (section == 2){
        return [self.fixingReturnArray count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleSection[3] = {@"已解决",@"未解决",@"正在解决"};
    
    return titleSection[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideniferstring = @"bugManageCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ideniferstring];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ideniferstring];
    }
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    Bug *bug = (section == 0) ? self.finishReturnArray[row] : (section == 1) ? self.unfinishReturnArray[row] : self.fixingReturnArray[row];
    NSString *content = bug.content;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",content];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 1000;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = _segue.destinationViewController;
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    Bug *bug = (section == 0) ? self.finishReturnArray[row] : (section == 1) ? self.unfinishReturnArray[row] : self.fixingReturnArray[row];
    [viewController setValue:bug forKey:@"bug"];
}


@end
