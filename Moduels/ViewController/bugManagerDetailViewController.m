//
//  bugManagerDetailViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-29.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "bugManagerDetailViewController.h"

@interface bugManagerDetailViewController () <UIActionSheetDelegate>

@property (nonatomic,strong) NSDictionary *paramDictory;

- (IBAction)fixItBug:(id)sender;

@end

@implementation bugManagerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.bug) {
        self.paramDictory = self.bug.toDictionary;
        self.navigationItem.rightBarButtonItem.enabled = ![self.bug.finish isEqualToString:@"已完成"];
    }
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
    
    NSInteger  row = [indexPath row];
    NSString *name = [self.paramDictory allKeys][row];
    NSString *content = [self.paramDictory allValues][row];
    NSString *cellContent = [NSString stringWithFormat:@"%@:%@",name,content];
    cell.textLabel.text = cellContent;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)fixItBug:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"修复bug"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"删除"
                                                    otherButtonTitles:@"正在解决",@"未解决",@"已经解决", nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        [self postFixItBugData:@"2"];
    }
    if (buttonIndex == actionSheet.firstOtherButtonIndex+1) {
        [self postFixItBugData:@"1"];
    }
    if (buttonIndex == actionSheet.firstOtherButtonIndex+2) {
        [self postFixItBugData:@"3"];
    }
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [self postDeletetBugData];
    }
}

- (void)postFixItBugData:(NSString *)state
{
    NSString *bugId = [NSString stringWithFormat:@"%d",self.bug.id];
    [RE_SINGLETON(DataGeterManager) postBugModifyStateWithBugId:bugId
                                                          state:state
                                                  completeBlock:^{
                                                      [self popBugManagerController];
                                                  } errorBlock:^(NSError *error) {
                                                      
                                                  }];
}

- (void)postDeletetBugData
{
    NSString *bugId = [NSString stringWithFormat:@"%d",self.bug.id];
    [RE_SINGLETON(DataGeterManager) postBugDeleteWithBugId:bugId
                                             completeBlock:^{
                                                 [self popBugManagerController];
                                             } errorBlock:^(NSError *error) {
                                                 
                                             }];
    
}

- (void)popBugManagerController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
